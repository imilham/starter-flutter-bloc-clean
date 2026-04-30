import 'dart:convert';
import 'dart:io';

/// Main configuration for the Swagger Code Generator.
/// Feel free to modify these maps to customize how code is generated.

/// Map of definition names in Swagger to their desired Dart class names.
const Map<String, String> definitionRenames = {
  'User': 'User',
  'AuthResponse': 'AuthResponse',
};

/// Map of specific operation IDs or "path:method" to custom method names.
const Map<String, String> methodRenames = {
  // 'auth_login_post': 'signIn',
};

/// Groups that should be skipped (e.g., if they are manually implemented).
const Set<String> skipGroups = {
  'auth',
  'profile',
  'onboarding',
};

/// Definitions to skip (e.g., if they are manually implemented).
const Set<String> skipDefinitions = {
  'ApiResponse',
  'Paginator',
  'User',
};

/// Map of specific path segments to groups.
const Map<String, List<String>> pathSegmentGroupsMapping = {
  // 'account': ['profile'],
};

/// Map of specific Swagger tags to groups.
const Map<String, List<String>> tagGroupsMapping = {
  // 'Auth': ['auth'],
};

/// Fields that should be flattened or have aliases.
const Map<String, Map<String, List<String>>> flattenedFields = {
  // 'ProductModel': {'video': ['product_video_url']},
};

/// Custom import paths for specific definitions.
const Map<String, String> customImportPaths = {
  // 'User': 'package:{pkg}/features/auth/domain/entities/user.dart',
};

/// Swagger primitive type references to ignore as objects.
const Set<String> _primitiveRefs = {
  'string', 'integer', 'number', 'boolean', 'array', 'object',
};

/// Entry point for the generator.
void main(List<String> args) async {
  final stopwatch = Stopwatch()..start();

  // 1. Configuration
  final dryRun = args.contains('--dry-run');
  final clean = args.contains('--clean');

  print('🚀 Starting Clean Architecture Swagger Code Generator...');
  if (dryRun) print('🔔 DRY RUN MODE: No files will be modified.');
  if (clean && !dryRun) {
    final genDir = Directory('lib/gen');
    if (genDir.existsSync()) {
      genDir.deleteSync(recursive: true);
      print('🧹 Cleaned lib/gen/');
    }
  }

  // 2. Initial Setup
  final packageName = _readPackageName();
  print('📦 Package: $packageName');

  // 3. Fetch Spec
  String jsonContent;
  try {
    if (args.isNotEmpty && args.first.startsWith('http')) {
      print('🌐 Fetching spec from ${args.first}...');
      jsonContent = await _fetchSwaggerSpec(args.first);
    } else if (File('swagger.json').existsSync()) {
      print('📂 Reading local swagger.json...');
      jsonContent = File('swagger.json').readAsStringSync();
    } else {
      print('❌ No swagger source found. Provide a URL as the first argument or create a local swagger.json.');
      exit(1);
    }
  } catch (e) {
    print('❌ Error fetching spec: $e');
    exit(1);
  }

  // 4. Parse
  final Map<String, dynamic> decoded;
  try {
    decoded = jsonDecode(jsonContent) as Map<String, dynamic>;
  } catch (e) {
    print('❌ Error parsing JSON: $e');
    exit(1);
  }

  final swagger = SwaggerSpec.fromJson(decoded);
  print('✅ Spec: ${swagger.title} (v${swagger.version})');

  // 5. Run Generation
  final generator = CodeGenerator(
    swagger: swagger,
    dryRun: dryRun,
    packageName: packageName,
  );
  generator.run();

  stopwatch.stop();
  print('\n✨ All done in ${stopwatch.elapsed.inSeconds}s!');
}

/// Reads the `name` field from pubspec.yaml to use as the package name in imports.
String _readPackageName() {
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('⚠️  pubspec.yaml not found, defaulting package name to "app"');
    return 'app';
  }
  final content = pubspecFile.readAsStringSync();
  final match = RegExp(r'^name:\s*(.+)$', multiLine: true).firstMatch(content);
  if (match == null) {
    print('⚠️  Could not read "name" from pubspec.yaml, defaulting to "app"');
    return 'app';
  }
  return match.group(1)!.trim();
}

/// Fetches spec from URL using HttpClient (no external dependencies required)
Future<String> _fetchSwaggerSpec(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode != 200) {
      throw HttpException('Failed to fetch spec (Status: ${response.statusCode})');
    }
    final content = await response.transform(utf8.decoder).join();
    return content;
  } finally {
    client.close();
  }
}

// ─── Swagger Parsing ──────────────────────────────────────────────────────────

class SwaggerSpec {
  SwaggerSpec({
    required this.title,
    required this.version,
    required this.basePath,
    required this.paths,
    required this.definitions,
  });

  factory SwaggerSpec.fromJson(Map<String, dynamic> json) {
    final info = json['info'] as Map<String, dynamic>? ?? {};
    final paths = <String, Map<String, SwaggerOperation>>{};
    final pathsJson = json['paths'] as Map<String, dynamic>? ?? {};

    for (final entry in pathsJson.entries) {
      final methodMap = <String, SwaggerOperation>{};
      final methods = entry.value as Map<String, dynamic>;
      for (final methodEntry in methods.entries) {
        methodMap[methodEntry.key] = SwaggerOperation.fromJson(
          methodEntry.value as Map<String, dynamic>,
          path: entry.key,
          method: methodEntry.key,
        );
      }
      paths[entry.key] = methodMap;
    }

    final definitions = <String, SwaggerDefinition>{};
    // Support both Swagger 2.0 'definitions' and OpenAPI 3.x 'components/schemas'
    final defsJson = json['definitions'] as Map<String, dynamic>? ??
        (json['components'] as Map<String, dynamic>?)?['schemas'] as Map<String, dynamic>? ??
        {};
    for (final entry in defsJson.entries) {
      // Sanitize definition names: strip &, commas, etc.
      final sanitizedName = entry.key.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
      definitions[sanitizedName] = SwaggerDefinition.fromJson(
        sanitizedName,
        entry.value as Map<String, dynamic>,
      );
    }

    return SwaggerSpec(
      title: info['title'] as String? ?? '',
      version: info['version'] as String? ?? '',
      basePath: json['basePath'] as String? ?? '',
      paths: paths,
      definitions: definitions,
    );
  }

  final String title;
  final String version;
  final String basePath;
  final Map<String, Map<String, SwaggerOperation>> paths;
  final Map<String, SwaggerDefinition> definitions;
}

class SwaggerOperation {
  SwaggerOperation({
    required this.path,
    required this.method,
    required this.tags,
    required this.summary,
    required this.operationId,
    required this.description,
    required this.parameters,
    required this.responses,
    required this.consumes,
    required this.security,
  });

  factory SwaggerOperation.fromJson(
    Map<String, dynamic> json, {
    required String path,
    required String method,
  }) {
    final params = <SwaggerParameter>[];
    final paramsJson = json['parameters'] as List<dynamic>? ?? [];
    for (final p in paramsJson) {
      params.add(SwaggerParameter.fromJson(p as Map<String, dynamic>));
    }

    final responses = <String, SwaggerResponse>{};
    final responsesJson = json['responses'] as Map<String, dynamic>? ?? {};
    for (final entry in responsesJson.entries) {
      responses[entry.key] = SwaggerResponse.fromJson(entry.value as Map<String, dynamic>);
    }

    final security = <Map<String, List<String>>>[];
    final securityJson = json['security'] as List<dynamic>? ?? [];
    for (final s in securityJson) {
      final secMap = <String, List<String>>{};
      for (final entry in (s as Map<String, dynamic>).entries) {
        secMap[entry.key] = (entry.value as List<dynamic>).cast<String>();
      }
      security.add(secMap);
    }

    return SwaggerOperation(
      path: path,
      method: method,
      tags: (json['tags'] as List<dynamic>?)?.map((t) => _sanitizeForIdentifier(t as String)).toList() ?? [],
      summary: json['summary'] as String? ?? '',
      operationId: (json['operationId'] as String? ?? '').replaceAll(RegExp('[^a-zA-Z0-9_]'), ''), 
      description: json['description'] as String? ?? '',
      parameters: params,
      responses: responses,
      consumes: (json['consumes'] as List<dynamic>?)?.cast<String>() ?? [],
      security: security,
    );
  }

  final String path;
  final String method;
  final List<String> tags;
  final String summary;
  final String operationId;
  final String description;
  final List<SwaggerParameter> parameters;
  final Map<String, SwaggerResponse> responses;
  final List<String> consumes;
  final List<Map<String, List<String>>> security;

  bool get requiresAuth => security.any((s) => s.containsKey('accessToken') || s.containsKey('bearerAuth'));

  List<SwaggerParameter> get queryParams => parameters.where((p) => p.location == 'query').toList();
  List<SwaggerParameter> get formParams => parameters.where((p) => p.location == 'formData').toList();
  List<SwaggerParameter> get pathParams => parameters.where((p) => p.location == 'path').toList();

  String? get successResponseRef {
    final r = responses['200'] ?? responses['201'] ?? responses['204'];
    return r?.schemaRef;
  }
}

class SwaggerParameter {
  SwaggerParameter({
    required this.name,
    required this.location,
    required this.required_,
    required this.description,
    required this.type,
    this.collectionFormat,
    this.itemsType,
    this.schemaRef,
    this.schema,
  });

  factory SwaggerParameter.fromJson(Map<String, dynamic> json) {
    String? itemsType;
    if (json['items'] != null) {
      itemsType = (json['items'] as Map<String, dynamic>)['type'] as String?;
    }
    String? schemaRef;
    if (json['schema'] != null) {
      schemaRef = (json['schema'] as Map<String, dynamic>)[r'$ref'] as String?;
      if (schemaRef != null) schemaRef = schemaRef.split('/').last.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
    }
    return SwaggerParameter(
      name: json['name'] as String? ?? '',
      location: json['in'] as String? ?? '',
      required_: json['required'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? 'string',
      collectionFormat: json['collectionFormat'] as String?,
      itemsType: itemsType,
      schemaRef: schemaRef,
      schema: json['schema'] as Map<String, dynamic>?,
    );
  }

  final String name;
  final String location;
  final bool required_;
  final String description;
  final String type;
  final String? collectionFormat;
  final String? itemsType;
  final String? schemaRef;
  final Map<String, dynamic>? schema;

  String get dartType {
    if (type == 'array') return 'List<String>';
    if (type == 'integer' || type == 'int') return 'int';
    if (type == 'number' || type == 'double') return 'double';
    if (type == 'boolean' || type == 'bool') return 'bool';
    if (type == 'file') return 'File';
    return 'String';
  }

  String get dartName => _safeDartName(name);
}

class SwaggerResponse {
  SwaggerResponse({this.schemaRef, this.description});

  factory SwaggerResponse.fromJson(Map<String, dynamic> json) {
    String? ref;
    if (json['schema'] != null) {
      final schema = json['schema'] as Map<String, dynamic>;
      ref = schema[r'$ref'] as String?;
      if (ref != null) ref = ref.split('/').last.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
    }
    return SwaggerResponse(schemaRef: ref, description: json['description'] as String?);
  }

  final String? schemaRef;
  final String? description;
}

class SwaggerDefinition {
  SwaggerDefinition({required this.name, required this.properties});

  factory SwaggerDefinition.fromJson(String name, Map<String, dynamic> json) {
    final props = <String, SwaggerProperty>{};
    final propsJson = json['properties'] as Map<String, dynamic>? ?? {};
    for (final entry in propsJson.entries) {
      props[entry.key] = SwaggerProperty.fromJson(entry.key, entry.value as Map<String, dynamic>);
    }
    return SwaggerDefinition(name: name, properties: props);
  }

  final String name;
  final Map<String, SwaggerProperty> properties;

  bool get isResponseWrapper {
    if (properties.isEmpty) return false;
    final allowedFields = {'result', 'message', 'data', 'payload', 'paginator', 'errors', 'status_code', 'token', 'success'};
    for (final propName in properties.keys) {
      if (!allowedFields.contains(propName)) return false;
    }
    return true;
  }
}

class SwaggerProperty {
  SwaggerProperty({
    required this.name,
    required this.type,
    this.ref,
    this.defaultValue,
    this.itemsRef,
    this.itemsType,
    this.properties = const {},
  });

  factory SwaggerProperty.fromJson(String name, Map<String, dynamic> json) {
    var ref = json[r'$ref'] as String?;
    if (ref != null) ref = ref.split('/').last.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
    if (ref != null && _primitiveRefs.contains(ref)) ref = null;

    String? itemsRef;
    String? itemsType;
    if (json['items'] != null) {
      final items = json['items'] as Map<String, dynamic>;
      itemsRef = items[r'$ref'] as String?;
      if (itemsRef != null) itemsRef = itemsRef.split('/').last.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
      if (itemsRef != null && _primitiveRefs.contains(itemsRef)) {
        itemsType = itemsRef.toLowerCase();
        itemsRef = null;
      }
      itemsType ??= items['type'] as String?;
    }

    final props = <String, SwaggerProperty>{};
    if (json['properties'] != null) {
      final propsJson = json['properties'] as Map<String, dynamic>;
      for (final entry in propsJson.entries) {
        props[entry.key] = SwaggerProperty.fromJson(entry.key, entry.value as Map<String, dynamic>);
      }
    }

    return SwaggerProperty(
      name: name,
      type: json['type'] as String? ?? (ref != null ? 'object' : 'string'),
      ref: ref,
      defaultValue: json['default'],
      itemsRef: itemsRef,
      itemsType: itemsType,
      properties: props,
    );
  }

  final String name;
  final String type;
  final String? ref;
  final dynamic defaultValue;
  final String? itemsRef;
  final String? itemsType;
  final Map<String, SwaggerProperty> properties;

  String get dartName => _safeDartName(name);

  String get dartType {
    if (ref != null) return definitionRenames[ref!] ?? ref!;
    if (type == 'array') {
      if (itemsRef != null) return 'List<${definitionRenames[itemsRef!] ?? itemsRef!}>';
      if (itemsType == 'integer' || itemsType == 'int') return 'List<int>';
      if (itemsType == 'number' || itemsType == 'double') return 'List<double>';
      if (itemsType == 'boolean' || itemsType == 'bool') return 'List<bool>';
      if (itemsType == 'string') return 'List<String>';
      return 'List<dynamic>';
    }
    if (type == 'integer' || type == 'int') return 'int';
    if (type == 'number' || type == 'double') return 'double';
    if (type == 'boolean' || type == 'bool') return 'bool';
    if (properties.isNotEmpty) return 'Map<String, dynamic>';
    return 'String';
  }

  bool get isNestedObject => ref != null || properties.isNotEmpty;
  bool get isNestedList => type == 'array' && (itemsRef != null || itemsType == 'object');
}

// ─── Code Generator ────────────────────────────────────────────────────────────

class CodeGenerator {
  CodeGenerator({required this.swagger, required this.dryRun, required this.packageName});

  final SwaggerSpec swagger;
  final bool dryRun;
  final String packageName;

  /// All generated code lands in lib/gen — the generator NEVER touches
  /// lib/features/<group>/presentation/ which is hand-written UI code.
  final String libDir = 'lib/gen';

  String get _pkg => 'package:$packageName';

  /// Package import prefix that points into the generated output folder.
  String get _genPkg => 'package:$packageName/gen';

  final Map<String, String> _modelImportPaths = {};
  late final Map<String, String> _definitionToGroup;
  final Set<String> _writtenFiles = {};

  void run() {
    // 1. Group operations by feature (derived from tags or path)
    final groupOps = <String, List<SwaggerOperation>>{};
    for (final pathEntry in swagger.paths.entries) {
      final path = pathEntry.key;
      for (final methodEntry in pathEntry.value.entries) {
        final op = methodEntry.value;
        final firstSegment = path.split('/').where((s) => s.isNotEmpty).firstOrNull;

        String group = 'common';
        if (firstSegment != null && pathSegmentGroupsMapping.containsKey(firstSegment)) {
          group = pathSegmentGroupsMapping[firstSegment]!.first;
        } else if (op.tags.isNotEmpty) {
          group = _tagToGroupName(op.tags.first);
        } else if (firstSegment != null) {
          group = _camelToSnake(firstSegment);
        }

        groupOps.putIfAbsent(group, () => []).add(op);
      }
    }

    // 2. Separate models and response wrappers
    final modelDefs = <String, SwaggerDefinition>{};
    final responseDefs = <String, SwaggerDefinition>{};
    for (final entry in swagger.definitions.entries) {
      if (entry.value.isResponseWrapper) {
        responseDefs[entry.key] = entry.value;
      } else {
        modelDefs[entry.key] = entry.value;
      }
    }
    _definitionToGroup = _computeDefinitionGroups(modelDefs, responseDefs, groupOps);

    // 3. Generate Data layer — Models
    print('\n── 📦 Models ──────────────────────────────────────────────');
    _generateAllModels(modelDefs, groupOps, responseDefs);

    // 4. Generate Data layer — DataSources
    print('\n── 📡 DataSources ──────────────────────────────────────────');
    for (final entry in groupOps.entries) {
      if (skipGroups.contains(entry.key)) continue;
      _generateDataSource(entry.key, entry.value, responseDefs);
    }

    // 5. Generate Domain layer — Entities, Repository interfaces, UseCases
    print('\n── 🏛  Domain Layer ─────────────────────────────────────────');
    for (final entry in groupOps.entries) {
      if (skipGroups.contains(entry.key)) continue;
      _generateDomainLayer(entry.key, entry.value, responseDefs, modelDefs);
    }

    // 6. Generate Endpoints file
    _generateEndpointsFile(groupOps);

    // 7. Generate barrel exports
    print('\n── 📋 Barrels ──────────────────────────────────────────────');
    _generateBarrels(groupOps);

    print('\n═══════════════════════════════════════════════════════════');
    print(' ✅ Code generation complete! → lib/gen/');
    print(' 💡 lib/features/*/presentation/ was not touched.');
    print('═══════════════════════════════════════════════════════════');
  }

  String _fileHeader(String description) {
    return '// Generated by swagger_codegen.dart\n// $description\n// DO NOT EDIT BY HAND\n\n';
  }

  String _tagToGroupName(String tag) {
    return _camelToSnake(_sanitizeForIdentifier(tag).replaceAll(RegExp(r'\s+'), ''));
  }

  Map<String, String> _computeDefinitionGroups(
    Map<String, SwaggerDefinition> modelDefs,
    Map<String, SwaggerDefinition> responseDefs,
    Map<String, List<SwaggerOperation>> groupOps,
  ) {
    final result = <String, String>{};
    // Trace which groups use which models
    for (final entry in groupOps.entries) {
      final group = entry.key;
      for (final op in entry.value) {
        if (op.successResponseRef != null) {
          _assignGroupToRef(op.successResponseRef!, group, result, modelDefs, responseDefs, {});
        }
        for (final p in op.parameters) {
          if (p.schemaRef != null) {
            _assignGroupToRef(p.schemaRef!, group, result, modelDefs, responseDefs, {});
          }
        }
      }
    }
    return result;
  }

  void _assignGroupToRef(String ref, String group, Map<String, String> result, Map<String, SwaggerDefinition> modelDefs, Map<String, SwaggerDefinition> responseDefs, Set<String> visited) {
    if (visited.contains(ref)) return;
    visited.add(ref);
    if (!result.containsKey(ref)) result[ref] = group;
    
    final def = modelDefs[ref] ?? responseDefs[ref];
    if (def != null) {
      for (final prop in def.properties.values) {
        if (prop.ref != null) _assignGroupToRef(prop.ref!, group, result, modelDefs, responseDefs, visited);
        if (prop.itemsRef != null) _assignGroupToRef(prop.itemsRef!, group, result, modelDefs, responseDefs, visited);
      }
    }
  }

  void _generateAllModels(Map<String, SwaggerDefinition> modelDefs, Map<String, List<SwaggerOperation>> groupOps, Map<String, SwaggerDefinition> responseDefs) {
    for (final entry in modelDefs.entries) {
      final name = entry.key;
      final def = entry.value;
      final group = _definitionToGroup[name] ?? 'common';
      if (skipDefinitions.contains(name)) continue;

      final fileName = _camelToSnake(name);
      final modelName = '${_pascalCase(name)}Model';
      final modelPath = '$libDir/features/$group/data/models/${fileName}_model.dart';
      
      final buffer = StringBuffer();
      buffer.writeln(_fileHeader('Model: $modelName'));
      buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
      buffer.writeln();
      buffer.writeln("part '${fileName}_model.freezed.dart';");
      buffer.writeln("part '${fileName}_model.g.dart';");
      buffer.writeln();
      buffer.writeln('@freezed');
      buffer.writeln('class $modelName with _\$$modelName {');
      buffer.writeln('  const factory $modelName({');
      
      for (final prop in def.properties.values) {
        final type = _dartFieldTypeForModel(prop);
        buffer.writeln("    @JsonKey(name: '${prop.name}') $type? ${prop.dartName},");
      }
      
      buffer.writeln('  }) = _$modelName;');
      buffer.writeln();
      buffer.writeln('  factory $modelName.fromJson(Map<String, dynamic> json) => _\$${modelName}FromJson(json);');
      buffer.writeln('}');
      
      _writeFile(modelPath, buffer.toString());
      _modelImportPaths[name] = '$_genPkg/features/$group/data/models/${fileName}_model.dart';
      print('   📄 Model: $modelName → $modelPath');
    }

    // Generate Request Models
    for (final entry in groupOps.entries) {
      final group = entry.key;
      for (final op in entry.value) {
        if (op.formParams.isNotEmpty || op.parameters.any((p) => p.location == 'body')) {
          final name = _operationToRequestModelName(op);
          final fileName = _camelToSnake(name);
          final modelName = '${name}Model';
          final modelPath = '$libDir/features/$group/data/models/${fileName}_model.dart';
          
          if (_writtenFiles.contains(modelPath)) continue;

          final buffer = StringBuffer();
          buffer.writeln(_fileHeader('Request Model: $modelName'));
          buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
          buffer.writeln();
          buffer.writeln("part '${fileName}_model.freezed.dart';");
          buffer.writeln("part '${fileName}_model.g.dart';");
          buffer.writeln();
          buffer.writeln('@freezed');
          buffer.writeln('class $modelName with _\$$modelName {');
          buffer.writeln('  const factory $modelName({');
          
          final props = _extractRequestProperties(op);
          for (final p in props) {
            buffer.writeln("    @JsonKey(name: '${p.name}') ${p.dartType}? ${p.dartName},");
          }
          
          buffer.writeln('  }) = _$modelName;');
          buffer.writeln();
          buffer.writeln('  factory $modelName.fromJson(Map<String, dynamic> json) => _\$${modelName}FromJson(json);');
          buffer.writeln('}');
          
          _writeFile(modelPath, buffer.toString());
          print('   📄 Request Model: $modelName → $modelPath');
        }
      }
    }
  }

  void _generateDataSource(String group, List<SwaggerOperation> ops, Map<String, SwaggerDefinition> responseDefs) {
    final pascal = _pascalCase(group);
    final className = '${pascal}RemoteDataSource';
    final fileBase = _camelToSnake(group);
    final abstractPath = '$libDir/features/$group/data/datasources/${fileBase}_remote_data_source.dart';
    final implPath = '$libDir/features/$group/data/datasources/${fileBase}_remote_data_source_impl.dart';

    // Collect feature-specific model imports.
    final modelImports = <String>{};
    for (final op in ops) {
      final ref = op.successResponseRef;
      if (ref != null && _modelImportPaths.containsKey(ref)) modelImports.add(_modelImportPaths[ref]!);
    }

    // ── Abstract definition ──
    final abstractBuffer = StringBuffer()
      ..writeln(_fileHeader('DataSource: $className'));
    for (final imp in modelImports) {
      abstractBuffer.writeln("import '$imp';");
    }
    abstractBuffer
      ..writeln()
      ..writeln('abstract class $className {');
    for (final op in ops) {
      final methodName = _sanitizeMethodName(_operationToMethodName(op));
      final returnType = _determineReturnType(op, responseDefs, forModel: true);
      final params = _buildMethodParams(op);
      abstractBuffer.writeln('  Future<$returnType> $methodName(${params.join(', ')});');
    }
    abstractBuffer.writeln('}');
    _writeFile(abstractPath, abstractBuffer.toString());
    print('   📄 DataSource: $className → $abstractPath');

    // ── Concrete implementation ──
    final implBuffer = StringBuffer()
      ..writeln(_fileHeader('DataSource Impl: ${className}Impl'))
      ..writeln("import '$_pkg/utils/utils.dart';")
      ..writeln("import '$_genPkg/features/$group/data/datasources/${fileBase}_remote_data_source.dart';");
    for (final imp in modelImports) {
      implBuffer.writeln("import '$imp';");
    }
    implBuffer
      ..writeln()
      ..writeln('class ${className}Impl implements $className {')
      ..writeln('  ${className}Impl({required this.apiClient});')
      ..writeln('  final ApiClient apiClient;')
      ..writeln();

    for (final op in ops) {
      _writeDataSourceMethod(implBuffer, op, responseDefs, pascal);
    }

    implBuffer.writeln('}');
    _writeFile(implPath, implBuffer.toString());
    print('   📄 DataSource Impl: ${className}Impl → $implPath');
  }

  void _writeDataSourceMethod(StringBuffer buffer, SwaggerOperation op, Map<String, SwaggerDefinition> responseDefs, String groupPascal) {
    final methodName = _sanitizeMethodName(_operationToMethodName(op));
    final returnType = _determineReturnType(op, responseDefs, forModel: true);
    final params = _buildMethodParams(op);
    final endpoint = '${groupPascal}Endpoints.${_endpointConstName(op)}';

    buffer.writeln('  @override');
    buffer.writeln('  Future<$returnType> $methodName(${params.join(', ')}) async {');
    buffer.writeln('    try {');
    buffer.writeln('      final response = await apiClient.${op.method}(');
    buffer.write('        $endpoint,');

    if (op.queryParams.isNotEmpty) {
      buffer.write('\n        queryParameters: <String, dynamic>{');
      for (final p in op.queryParams) {
        buffer.write("'${p.name}': ${p.dartName}, ");
      }
      buffer.write('},');
    }

    if (op.method != 'get') {
      if (op.formParams.isNotEmpty) {
        buffer.write('\n        data: FormData.fromMap(request.toJson()),');
      } else if (op.parameters.any((p) => p.location == 'body')) {
        buffer.write('\n        data: request.toJson(),');
      }
    }

    buffer.writeln('\n      );');
    buffer.writeln('      final apiResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>);');
    buffer.writeln('      if (apiResponse.isFailure) {');
    buffer.writeln('        throw ApiError(message: apiResponse.message);');
    buffer.writeln('      }');

    if (returnType == 'bool') {
      buffer.writeln('      return true;');
    } else if (returnType.endsWith('Model')) {
      buffer.writeln('      return $returnType.fromJson(apiResponse.data as Map<String, dynamic>);');
    } else if (returnType.startsWith('List')) {
      final itemType = RegExp(r'List<(\w+)>').firstMatch(returnType)?.group(1) ?? 'dynamic';
      buffer.writeln('      return (apiResponse.data as List<dynamic>)');
      buffer.writeln('          .map((e) => $itemType.fromJson(e as Map<String, dynamic>))');
      buffer.writeln('          .toList();');
    } else {
      buffer.writeln('      return apiResponse.data;');
    }

    buffer.writeln('    } on DioException catch (e) {');
    buffer.writeln('      return onError(e);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();
  }

  void _generateEndpointsFile(Map<String, List<SwaggerOperation>> groupOps) {
    final buffer = StringBuffer();
    buffer.writeln(_fileHeader('API Endpoints'));
    buffer.writeln('class Endpoints {');
    buffer.writeln('  const Endpoints._();');
    buffer.writeln('}');
    buffer.writeln();

    for (final entry in groupOps.entries) {
      final group = entry.key;
      final ops = entry.value;
      buffer.writeln('class ${_pascalCase(group)}Endpoints {');
      for (final op in ops) {
        buffer.writeln("  static const String ${_endpointConstName(op)} = '${op.path}';");
      }
      buffer.writeln('}');
      buffer.writeln();
    }

    _writeFile('$libDir/utils/network/endpoints.dart', buffer.toString());
  }

  // ── Domain Layer ─────────────────────────────────────────────────────────────

  /// Generates the full domain layer for [group]:
  ///   domain/entities/        — plain Equatable classes (no JSON)
  ///   domain/repositories/    — abstract repository interface
  ///   domain/usecases/        — one thin UseCase class per operation
  void _generateDomainLayer(
    String group,
    List<SwaggerOperation> ops,
    Map<String, SwaggerDefinition> responseDefs,
    Map<String, SwaggerDefinition> modelDefs,
  ) {
    final pascal = _pascalCase(group);

    // Collect entity names this group needs
    final entityNames = <String>{};
    for (final op in ops) {
      final returnType = _determineReturnType(op, responseDefs, forModel: false);
      final entityType = _modelTypeToEntityType(returnType);
      if (entityType != null) entityNames.add(entityType);
    }

    // 1. Entities
    for (final entityName in entityNames) {
      _generateEntity(group, entityName, modelDefs);
    }

    // 2. Repository interface
    _generateRepositoryInterface(group, ops, responseDefs);

    // 3. UseCases — one per operation
    for (final op in ops) {
      _generateUseCase(group, op, responseDefs);
    }

    print('   🏛  Domain: $pascal (${entityNames.length} entities, ${ops.length} usecases)');
  }

  void _generateEntity(String group, String entityName, Map<String, SwaggerDefinition> modelDefs) {
    final fileName = _camelToSnake(entityName);
    final path = '$libDir/features/$group/domain/entities/$fileName.dart';
    final defName = entityName; // e.g. 'Product'
    final def = modelDefs[defName];

    final buffer = StringBuffer();
    buffer.writeln(_fileHeader('Entity: $entityName'));
    buffer.writeln("import 'package:equatable/equatable.dart';");
    buffer.writeln();
    buffer.writeln('class $entityName extends Equatable {');
    buffer.writeln('  const $entityName({');

    if (def != null) {
      for (final prop in def.properties.values) {
        buffer.writeln('    this.${prop.dartName},');
      }
    }

    buffer.writeln('  });');
    buffer.writeln();

    if (def != null) {
      for (final prop in def.properties.values) {
        final type = _entityFieldType(prop);
        buffer.writeln('  final $type? ${prop.dartName};');
      }
    }

    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  List<Object?> get props => [');
    if (def != null) {
      for (final prop in def.properties.values) {
        buffer.writeln('    ${prop.dartName},');
      }
    }
    buffer.writeln('  ];');
    buffer.writeln('}');

    _writeFile(path, buffer.toString());
  }

  void _generateRepositoryInterface(
    String group,
    List<SwaggerOperation> ops,
    Map<String, SwaggerDefinition> responseDefs,
  ) {
    final pascal = _pascalCase(group);
    final fileBase = _camelToSnake(group);
    final path = '$libDir/features/$group/domain/repositories/${fileBase}_repository.dart';

    final buffer = StringBuffer();
    buffer.writeln(_fileHeader('Repository interface: ${pascal}Repository'));
    buffer.writeln("import 'package:dartz/dartz.dart';");
    buffer.writeln("import '$_pkg/core/core.dart';");
    buffer.writeln();

    // Import entities
    final importedEntities = <String>{};
    for (final op in ops) {
      final entityType = _modelTypeToEntityType(_determineReturnType(op, responseDefs, forModel: false));
      if (entityType != null && !importedEntities.contains(entityType)) {
        final fileName = _camelToSnake(entityType);
        buffer.writeln("import '$_genPkg/features/$group/domain/entities/$fileName.dart';");
        importedEntities.add(entityType);
      }
    }

    buffer.writeln();
    buffer.writeln('abstract class ${pascal}Repository {');
    for (final op in ops) {
      final methodName = _sanitizeMethodName(_operationToMethodName(op));
      final returnType = _entityReturnType(op, responseDefs);
      final params = _buildMethodParams(op);
      buffer.writeln('  Future<Either<Failure, $returnType>> $methodName(${params.join(', ')});');
    }
    buffer.writeln('}');

    _writeFile(path, buffer.toString());
  }

  void _generateUseCase(
    String group,
    SwaggerOperation op,
    Map<String, SwaggerDefinition> responseDefs,
  ) {
    final methodName = _sanitizeMethodName(_operationToMethodName(op));
    final useCaseName = '${_pascalCase(methodName)}UseCase';
    final fileBase = _camelToSnake(methodName);
    final path = '$libDir/features/$group/domain/usecases/$fileBase\_use_case.dart';
    final repoInterface = '${_pascalCase(group)}Repository';
    final repoFileBase = _camelToSnake(group);
    final returnType = _entityReturnType(op, responseDefs);

    final params = _buildMethodParams(op);
    final hasParams = params.isNotEmpty;
    final paramsClass = '${_pascalCase(methodName)}Params';

    final buffer = StringBuffer();
    buffer.writeln(_fileHeader('UseCase: $useCaseName'));
    buffer.writeln("import 'package:dartz/dartz.dart';");
    buffer.writeln("import '$_pkg/core/core.dart';");
    buffer.writeln("import '$_genPkg/features/$group/domain/repositories/${repoFileBase}_repository.dart';");
    buffer.writeln();

    if (hasParams) {
      buffer.writeln('class $paramsClass {');
      buffer.writeln('  const $paramsClass({');
      for (final p in params) {
        // p is like "String? email" — extract name
        final parts = p.trim().split(' ');
        final paramName = parts.last;
        buffer.writeln('    required this.$paramName,');
      }
      buffer.writeln('  });');
      buffer.writeln();
      for (final p in params) {
        buffer.writeln('  final $p;');
      }
      buffer.writeln('}');
      buffer.writeln();
    }

    buffer.writeln('class $useCaseName {');
    buffer.writeln('  const $useCaseName(this._repository);');
    buffer.writeln('  final $repoInterface _repository;');
    buffer.writeln();
    if (hasParams) {
      buffer.writeln('  Future<Either<Failure, $returnType>> call($paramsClass params) =>');
      final callArgs = params.map((p) {
        final paramName = p.trim().split(' ').last;
        return 'params.$paramName';
      }).join(', ');
      buffer.writeln('      _repository.$methodName($callArgs);');
    } else {
      buffer.writeln('  Future<Either<Failure, $returnType>> call() =>');
      buffer.writeln('      _repository.$methodName();');
    }
    buffer.writeln('}');

    _writeFile(path, buffer.toString());
  }

  // ── Barrels ──────────────────────────────────────────────────────────────────

  /// Generates per-feature and top-level barrel files so the presentation layer
  /// can import one line: `import 'package:app/gen/features/products/products.dart'`
  void _generateBarrels(Map<String, List<SwaggerOperation>> groupOps) {
    final topLevelExports = <String>[];

    for (final group in groupOps.keys) {
      if (skipGroups.contains(group)) continue;
      final fileBase = _camelToSnake(group);
      final barrelPath = '$libDir/features/$group/$fileBase.dart';
      final buffer = StringBuffer();
      buffer.writeln(_fileHeader('Barrel: $group'));

      // Data — models
      buffer.writeln("// Data layer");
      final modelDir = Directory('$libDir/features/$group/data/models');
      if (!dryRun && modelDir.existsSync()) {
        for (final f in modelDir.listSync().whereType<File>()) {
          if (f.path.endsWith('.dart') && !f.path.contains('.freezed') && !f.path.contains('.g.dart')) {
            final name = f.uri.pathSegments.last;
            buffer.writeln("export 'data/models/$name';");
          }
        }
      } else {
        buffer.writeln("// export 'data/models/<name>_model.dart';");
      }

      // Data — datasources
      buffer.writeln("// DataSources");
      buffer.writeln("export 'data/datasources/${fileBase}_remote_data_source.dart';");

      // Domain — entities
      buffer.writeln("// Domain layer");
      final entityDir = Directory('$libDir/features/$group/domain/entities');
      if (!dryRun && entityDir.existsSync()) {
        for (final f in entityDir.listSync().whereType<File>()) {
          if (f.path.endsWith('.dart')) {
            final name = f.uri.pathSegments.last;
            buffer.writeln("export 'domain/entities/$name';");
          }
        }
      } else {
        buffer.writeln("// export 'domain/entities/<name>.dart';");
      }

      buffer.writeln("export 'domain/repositories/${fileBase}_repository.dart';");
      buffer.writeln("// export 'domain/usecases/<operation>_use_case.dart';");

      _writeFile(barrelPath, buffer.toString());
      topLevelExports.add("export 'features/$group/$fileBase.dart';");
      print('   📋 Barrel: $barrelPath');
    }

    // Top-level gen.dart
    final genBarrel = StringBuffer();
    genBarrel.writeln(_fileHeader('Top-level gen barrel — import this in your features'));
    genBarrel.writeln("export 'utils/network/endpoints.dart';");
    genBarrel.writeln();
    for (final e in topLevelExports) {
      genBarrel.writeln(e);
    }
    _writeFile('$libDir/gen.dart', genBarrel.toString());
    print('   📋 Top-level barrel: $libDir/gen.dart');
  }

  // ── Type helpers ─────────────────────────────────────────────────────────────

  /// Converts a Model type string to its entity equivalent.
  /// e.g. `ProductModel` → `Product`, `List<ProductModel>` → `Product` (just the name)
  String? _modelTypeToEntityType(String modelType) {
    if (modelType == 'bool' || modelType == 'dynamic' || modelType == 'String') return null;
    if (modelType.endsWith('Model')) return modelType.replaceFirst(RegExp(r'Model$'), '');
    final listMatch = RegExp(r'List<(\w+)Model>').firstMatch(modelType);
    if (listMatch != null) return listMatch.group(1);
    return null;
  }

  /// Entity return type for repository / usecase signatures.
  String _entityReturnType(SwaggerOperation op, Map<String, SwaggerDefinition> responseDefs) {
    final modelType = _determineReturnType(op, responseDefs, forModel: true);
    if (modelType == 'bool') return 'bool';
    if (modelType.endsWith('Model')) return modelType.replaceFirst(RegExp(r'Model$'), '');
    if (modelType.startsWith('List<') && modelType.endsWith('Model>')) {
      return modelType.replaceFirst(RegExp(r'Model>$'), '>');
    }
    return modelType;
  }

  /// Dart type for an entity field (no Model suffix, no JSON).
  String _entityFieldType(SwaggerProperty prop) {
    if (prop.ref != null) return definitionRenames[prop.ref!] ?? prop.ref!;
    if (prop.type == 'array' && prop.itemsRef != null) {
      return 'List<${definitionRenames[prop.itemsRef!] ?? prop.itemsRef!}>';
    }
    return prop.dartType;
  }

  // --- Support Helpers ---

  void _writeFile(String path, String content) {
    final normalised = path.replaceAll(r'\', '/');
    _writtenFiles.add(normalised);
    if (dryRun) {
      print('   [dry-run] would write → $normalised');
      return;
    }
    final file = File(path);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
  }

  // ... (String utils, parsing helpers, etc. truncated for brevity but would be full implementation)
  
  String _operationToMethodName(SwaggerOperation op) {
    if (op.operationId.isNotEmpty) return _snakeToCamel(op.operationId);
    return _snakeToCamel('${op.method}_${op.path.replaceAll('/', '_').replaceAll('{', '').replaceAll('}', '')}');
  }

  String _operationToRequestModelName(SwaggerOperation op) {
    final base = _operationToMethodName(op);
    return '${base[0].toUpperCase()}${base.substring(1)}Request';
  }

  String _endpointConstName(SwaggerOperation op) => _sanitizeMethodName(_operationToMethodName(op));

  /// Sanitize a method name to be a valid Dart identifier.
  String _sanitizeMethodName(String name) {
    var result = name.replaceAll(RegExp('[^a-zA-Z0-9_]'), '');
    if (result.isEmpty) result = 'operation';
    if (RegExp(r'^[0-9]').hasMatch(result)) result = 'op$result';
    if (_dartReservedKeywords.contains(result)) result = '${result}Method';
    return result;
  }

  List<String> _buildMethodParams(SwaggerOperation op) {
    final params = <String>[];
    if (op.formParams.isNotEmpty || op.parameters.any((p) => p.location == 'body')) {
      params.add('${_operationToRequestModelName(op)}Model request');
    }
    for (final p in op.pathParams) params.add('${p.dartType} ${p.dartName}');
    for (final p in op.queryParams) params.add('${p.dartType}? ${p.dartName}');
    return params;
  }

  String _determineReturnType(SwaggerOperation op, Map<String, SwaggerDefinition> responseDefs, {bool forModel = false}) {
    final ref = op.successResponseRef;
    if (ref == null) return 'bool';
    final def = responseDefs[ref];
    final payload = def?.properties['data'] ?? def?.properties['payload'];
    if (payload == null) return 'dynamic';
    return forModel ? _dartFieldTypeForModel(payload) : payload.dartType;
  }

  String _dartFieldTypeForModel(SwaggerProperty prop) {
    if (prop.ref != null) return '${definitionRenames[prop.ref!] ?? prop.ref!}Model';
    if (prop.type == 'array' && prop.itemsRef != null) return 'List<${definitionRenames[prop.itemsRef!] ?? prop.itemsRef!}Model>';
    return prop.dartType;
  }

  List<_RequestProp> _extractRequestProperties(SwaggerOperation op) {
    // Basic extraction logic similar to original but targeting data model properties
    return op.parameters.where((p) => p.location == 'formData' || p.location == 'body').map((p) => _RequestProp(
      name: p.name,
      dartName: p.dartName,
      dartType: p.dartType,
      isRequired: p.required_,
    )).toList();
  }
}

class _RequestProp {
  _RequestProp({required this.name, required this.dartName, required this.dartType, required this.isRequired});
  final String name;
  final String dartName;
  final String dartType;
  final bool isRequired;
}

const _dartReservedKeywords = <String>{'assert', 'break', 'case', 'catch', 'class', 'const', 'continue', 'default', 'do', 'else', 'enum', 'extends', 'false', 'final', 'finally', 'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return', 'super', 'switch', 'this', 'throw', 'true', 'try', 'var', 'void', 'while', 'with'};

String _snakeToCamel(String input) {
  final parts = input.split(RegExp(r'[_\-.]'));
  if (parts.isEmpty) return input;
  return parts.first + parts.sublist(1).map((s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1)).join();
}

String _safeDartName(String raw) {
  var result = _snakeToCamel(raw.replaceAll(RegExp(r'\[.*?\]'), ''));
  if (result.isEmpty) result = 'field';
  if (RegExp(r'^[0-9]').hasMatch(result)) result = 'field$result';
  if (_dartReservedKeywords.contains(result)) result = '${result}Field';
  return result;
}

String _sanitizeForIdentifier(String input) => input.replaceAll(RegExp(r'[^a-zA-Z0-9_\s\-]'), ' ').trim();
String _camelToSnake(String input) => input.replaceAllMapped(RegExp('([A-Z])'), (m) => '_${m.group(1)!.toLowerCase()}').replaceAll(RegExp('^_'), '');
String _pascalCase(String input) => input.split(RegExp(r'[_\-\s]+')).map((s) => s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '').join();
