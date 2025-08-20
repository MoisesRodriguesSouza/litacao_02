import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;

const String csvFolder = 'data';
const String outputFolder = 'firestore_data';

const String sectorsCsvFile = 'sectors.csv';
const String processesCsvFile = 'processes.csv';

final Map<String, String> sectorNameToId = {
  "GABINETE DO SECRETÁRIO": "gabinete_secretario",
  "RECEPÇÃO / PROTOCOLO": "recepcao_protocolo",
  "COORDENADOR DE ATIVIDADES ADMINISTRATIVAS DO GABINETE DO SECRETÁRIO":
      "coord_ativ_adm_gabinete",
  "CHEFIA DE GABINETE": "chefia_gabinete",
  "SUBSECRETÁRIO(A) MUNICIPAL DE EDUCAÇÃO": "subsecretario_educacao",
  "ASSESSORIA TÉCNICA DE LICITAÇÃO PRESIDENTE DA CL": "ass_tec_licitacao",
  "ASSESSORIA TÉCNICA JURÍDICA EDUCACIONAL": "ass_tec_juridica",
  "ASSESSORIA TÉCNICA PARA CONTROLADORIA INTERNA DA EDUCAÇÃO":
      "ass_tec_controladoria",
  "COORDENAÇÃO DE CONTROLE INTERNO E ACOMPANHAMENTO DA EXECUÇÃO ORÇAMENTÁRIA":
      "coord_controle_interno",
  "COORDENAÇÃO DE OUVIDORIA": "coord_ouvidoria",
  "ASSESSORIA JURÍDICA": "assessoria_juridica",
  "COORDENAÇÃO DE PLANEJAMENTO DE COMPRAS": "coord_planej_compras",
  "COORDENAÇÃO DE REGISTRO E PESQUISA DE PREÇOS": "coord_reg_pesquisa_precos",
  "DIRETORIA ADMINISTRATIVA": "diretoria_administrativa",
  "SUBSECRETARIA ADJUNTA ADMINISTRATIVA": "subsec_adj_administrativa",
  "SUBSECRETARIA ADJUNTA DE ASSUNTOS EDUCACIONAIS":
      "subsec_adj_ass_educacionais",
  "DIRETORIA DO DEPARTAMENTO PEDAGÓGICO": "diretoria_depto_pedagogico",
  "COORDENAÇÃO DE ED. INFANTIL": "coord_ed_infantil",
  "COORDENAÇÃO DE APOIO DO CICLO DE ALFABETIZAÇÃO": "coord_apoio_alfabetizacao",
  "COORDENAÇÃO DE APOIO DOS ANOS INICIAIS 3º AO 5º ANO":
      "coord_apoio_anos_iniciais",
  "COORDENAÇÃO DE APOIO DOS ANOS FINAIS 6º AO 9º ANO":
      "coord_apoio_anos_finais",
  "COORDENAÇÃO DE EJA": "coord_eja",
  "COORDENAÇÃO DE AVALIAÇÃO DA APRENDIZAGEM": "coord_avaliacao_aprendizagem",
  "COORDENAÇÃO DE ESPORTES E ARTE": "coord_esportes_arte",
  "COORDENAÇÃO DE APOIO A PROGRAMAS ESPECIAIS DO MEC": "coord_apoio_prog_mec",
  "COORDENAÇÃO DE APOIO DE EDUCAÇÃO INTEGRAL": "coord_apoio_ed_integral",
  "DIRETORIA DE CENSO E MATRÍCULAS": "diretoria_censo_matriculas",
  "COORDENAÇÃO DE APOIO DE REGISTRO E CONTROLE ACADÊMICO":
      "coord_apoio_reg_acad",
  "COORDENADOR DE APOIO A PERMANÊNCIA ESTUDANTIL": "coord_apoio_permanencia",
  "DIRETORIA DE ATENDIMENTO EDUCACIONAL ESPECIALIZADO":
      "diretoria_atend_educ_esp",
  "COORDENAÇÃO DE EDUCAÇÃO ESPECIAL": "coord_educacao_especial",
  "DIRETORIA DE SUPERVISÃO E ACOMPANHAMENTO DA GESTÃO ESCOLAR":
      "diretoria_supervisao_gestao",
  "COORDENAÇÃO DE APOIO DE SUPERVISÃO ESCOLAR": "coord_apoio_supervisao",
  "CONSELHO MUNICIPAL DE EDUCAÇÃO": "conselho_municipal_educacao",
  "DIRETORIA DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO DA EDUCAÇÃO":
      "diretoria_planej_orc_fin",
  "DIRETORIA DE CONTROLE E EXECUÇÃO ORÇAMENTÁRIA E FINANCEIRA DA EDUCAÇÃO":
      "diretoria_controle_exec_orc",
  "COORDENAÇÃO DE CONTABILIDADE, ORÇAMENTO E FINANÇAS":
      "coord_contabilidade_orc_fin",
  "ASSESSOR DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO":
      "assessor_planej_orc_fin",
  "ASSESSOR DE CONTROLE E EXECUÇÃO ORÇAMENTÁRIA E FINANCEIRA":
      "assessor_controle_exec_orc",
  "DEPARTAMENTO FINANCEIRO": "departamento_financeiro",
  "ASSESSORIA TÉCNICA CONTÁBIL": "assessoria_tec_contabil",
  "SUBSECRETARIA ADJUNTA FINANCEIRA": "subsecretaria_adj_financeira",
  "COORDENAÇÃO DE PRESTAÇÃO DE CONTAS": "coord_prestacao_contas",
  "ASSESSORIA TÉCNICA PARA SUPERINTENDÊNCIA DO FUNDO MUNICIPAL DE EDUCAÇÃO":
      "ass_tec_superint_fme",
  "DIRETORIA DE INFRAESTRUTURA": "diretoria_infraestrutura",
  "COORDENAÇÃO DE MANUTENÇÃO": "coord_manutencao",
  "COORDENAÇÃO DE PROJETOS DE INFRAESTRUTURA": "coord_projetos_infraestrutura",
  "ASSESSORIA TÉCNICA DE INFRAESTRUTURA": "assessoria_tec_infraestrutura",
  "SUBSECRETARIA ADJUNTA DE INFRAESTRUTURA": "subsecretaria_adj_infraestrutura",
  "ASSESSOR DE MANUTENÇÃO - EDIFICAÇÕES": "assessor_manutencao_edif",
  "Subsecretaria Adjunta de Inovação e Tecnologia SEMED":
      "subsecretaria_adj_inovacao_tecnologia",
  "SUBSECRETARIA ADJUNTA ADMINISTRATIVA SEMED":
      "subsecretaria_adj_administrativa_semed",
  "ASSESSORIA TÉCNICA / SEMED": "assessoria_tecnica_semed",
  "DIRETORIA DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO":
      "diretoria_de_planejamento_orcamentario_financeiro",
  "DIRETORIA DE INFRAESTRUTURA SEMED": "diretoria_de_infraestrutura_semed",
  "SUBSECRETARIA ADJUNTA DE ASSUNTOS EDUCACIONAIS SEMED":
      "subsecretaria_adjunta_de_assuntos_educacionais_semed",
  "DIRETORIA DE ATENDIMENTO EDUCACIONAL ESPECIALIZADO SEMED":
      "diretoria_de_atendimento_educacional_especializado_semed",
  "DIRETORIA DE SUPERVISÃO E ACOMPANHAMENTO DA GESTÃO ESCOLAR SEMED":
      "diretoria_de_supervisao_e_acompanhamento_da_gestao_escolar_semed",
  "CONSELHO MUNICIPAL DE EDUCAÇÃO SEMED":
      "conselho_municipal_de_educacao_semed",
  "Administração": "administracao",
  "Compras": "compras",
  "Patrimônio": "patrimonio",
  "Secretaria de Educação": "secretaria_de_educacao",
  "Frota": "frota",
  "Finanças": "financas",
  "TI": "ti",
  "Meio Ambiente": "meio_ambiente",
  "Gabinete": "gabinete",
  "Arquivo": "arquivo",
  "Eventos": "eventos",
  "Obras": "obras",
  "Segurança": "seguranca",
  "Secretaria de Agricultura": "secretaria_de_agricultura",
};

final Map<String, String> assessorNameToId = {
  "GUILHERME": "guilherme_uid",
  "João Silva": "joao_silva_uid",
  "Maria Souza": "maria_souza_uid",
  "Carlos Pereira": "carlos_pereira_uid",
  "Ana Santos": "ana_santos_uid",
  "Lucas Ferreira": "lucas_ferreira_uid",
};

Future<void> convertSectors() async {
  final csvFilePath = p.join(csvFolder, sectorsCsvFile);
  final outputFilePath = p.join(outputFolder, 'sectors.json');

  if (!File(csvFilePath).existsSync()) {
    print(
      "Erro: O ficheiro '$sectorsCsvFile' não foi encontrado em '$csvFolder'.",
    );
    return;
  }

  final input = File(csvFilePath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  final Map<String, Map<String, dynamic>> sectorsData = {};
  final headers = fields[0];
  final nameIndex = headers.indexOf('name (Nome do Setor)');
  final codeIndex = headers.indexOf('code (Código)');

  if (nameIndex == -1 || codeIndex == -1) {
    print(
      "Erro: Cabeçalhos CSV 'name (Nome do Setor)' ou 'code (Código)' não encontrados em $sectorsCsvFile.",
    );
    return;
  }

  for (var i = 1; i < fields.length; i++) {
    final row = fields[i];
    if (row.length > nameIndex && row[nameIndex] != null) {
      final sectorName = row[nameIndex].toString().trim();
      final sectorId =
          sectorNameToId[sectorName] ??
          sectorName
              .toLowerCase()
              .replaceAll(' ', '_')
              .replaceAll('/', '_')
              .replaceAll(RegExp(r'[()]'), '');

      sectorsData[sectorId] = {
        "name": sectorName,
        "code": row.length > codeIndex
            ? (row[codeIndex]?.toString().trim() ?? '')
            : '',
        "active": true,
      };
    }
  }

  final outputJson = JsonEncoder.withIndent('  ').convert(sectorsData);
  File(outputFilePath).writeAsStringSync(outputJson);
  print("Sectores convertidos e salvos em: $outputFilePath");
}

Future<void> convertProcesses() async {
  final csvFilePath = p.join(csvFolder, processesCsvFile);
  final outputFilePath = p.join(outputFolder, 'processes.json');

  if (!File(csvFilePath).existsSync()) {
    print(
      "Erro: O ficheiro '$processesCsvFile' não foi encontrado em '$csvFolder'.",
    );
    return;
  }

  final input = File(csvFilePath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  final Map<String, Map<String, dynamic>> processesData = {};
  final headers = fields[0];

  final Map<String, int> headerIndex = {};
  for (int i = 0; i < headers.length; i++) {
    headerIndex[headers[i].toString().trim()] = i;
  }

  for (var i = 1; i < fields.length; i++) {
    final row = fields[i];

    final processNumberRaw = _getValue(row, headerIndex, 'processNumber') ?? '';
    final String processId =
        "process_${processNumberRaw.replaceAll('/', '_').replaceAll('.', '_')}_$i";

    final objectDescription =
        _getValue(row, headerIndex, 'objectDescription') ?? '';
    final rawSectorName = _getValue(row, headerIndex, 'sectorId') ?? '';
    final sectorId =
        sectorNameToId[rawSectorName] ??
        rawSectorName
            .toLowerCase()
            .replaceAll(' ', '_')
            .replaceAll('/', '_')
            .replaceAll(RegExp(r'[()]'), '');
    final rawAssessorName = _getValue(row, headerIndex, 'assessorId') ?? '';
    final assessorId =
        assessorNameToId[rawAssessorName] ??
        rawAssessorName.toLowerCase().replaceAll(' ', '_');
    final modality = _getValue(row, headerIndex, 'modality') ?? '';
    final currentPhase = _getValue(row, headerIndex, 'currentPhase') ?? '';
    final status = _getValue(row, headerIndex, 'status') ?? '';
    final observations = _getValue(row, headerIndex, 'observations') ?? '';
    final estimatedValueRaw =
        _getValue(row, headerIndex, 'estimatedValue') ?? '0.0';
    final openingDateRaw = _getValue(row, headerIndex, 'openingDate') ?? 'N/A';
    final lastActivityDateRaw =
        _getValue(row, headerIndex, 'lastActivityDate') ?? 'N/A';
    final isRenewableRaw =
        _getValue(row, headerIndex, 'isRenewable') ?? 'false';
    final contractId = _getValue(row, headerIndex, 'contractId');
    final delayReason = _getValue(row, headerIndex, 'delayReason');
    final expectedCompletionDateRaw =
        _getValue(row, headerIndex, 'expectedCompletionDate') ?? 'N/A';
    final actualCompletionDateRaw =
        _getValue(row, headerIndex, 'actualCompletionDate') ?? 'N/A';

    String contractType = "Outro";
    if (objectDescription.toLowerCase().contains("serviço") ||
        modality.toLowerCase().contains("serviço")) {
      contractType = "Serviço";
    } else if (objectDescription.toLowerCase().contains("aquisição") ||
        modality.toLowerCase().contains("aquisição")) {
      contractType = "Bens";
    } else if (objectDescription.toLowerCase().contains("locação") ||
        modality.toLowerCase().contains("locação")) {
      contractType = "Locação";
    }

    DateTime? parseDate(String dateStr, String processNum) {
      if (dateStr == 'N/A' || dateStr.isEmpty) return null;
      try {
        if (dateStr.contains('/')) {
          final parts = dateStr.split('/');
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else if (dateStr.contains('-') && dateStr.split('-')[0].length == 4) {
          return DateTime.parse(dateStr);
        } else if (dateStr.contains('-') && dateStr.split('-')[0].length == 2) {
          final parts = dateStr.split('-');
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      } catch (e) {
        print(
          "Aviso: Data inválida para o processo $processNum: '$dateStr'. Erro: $e",
        );
      }
      return null;
    }

    final openingDate =
        parseDate(openingDateRaw, processNumberRaw) ?? DateTime.now();
    final lastActivityDate =
        parseDate(lastActivityDateRaw, processNumberRaw) ?? DateTime.now();
    final expectedCompletionDate = parseDate(
      expectedCompletionDateRaw,
      processNumberRaw,
    );
    final actualCompletionDate = parseDate(
      actualCompletionDateRaw,
      processNumberRaw,
    );

    final isRenewable =
        isRenewableRaw.toLowerCase() == 'sim' ||
        isRenewableRaw.toLowerCase() == 'true';

    final doc = {
      "processNumber": processNumberRaw,
      "objectDescription": objectDescription,
      "sectorId": sectorId,
      "assessorId": assessorId,
      "modality": modality,
      "contractType": contractType,
      "currentPhase": currentPhase,
      "status": status,
      "observations": observations,
      "estimatedValue":
          double.tryParse(estimatedValueRaw.replaceAll(',', '.')) ?? 0.0,
      "openingDate": "${openingDate.toIso8601String()}Z",
      "expectedCompletionDate": expectedCompletionDate != null
          ? "${expectedCompletionDate.toIso8601String()}Z"
          : null,
      "actualCompletionDate": actualCompletionDate != null
          ? "${actualCompletionDate.toIso8601String()}Z"
          : null,
      "delayReason": delayReason,
      "lastActivityDate": "${lastActivityDate.toIso8601String()}Z",
      "attachments": [],
      "isRenewable": isRenewable,
      "contractId": contractId,
    };
    processesData[processId] = doc;
  }

  final outputJson = JsonEncoder.withIndent('  ').convert(processesData);
  File(outputFilePath).writeAsStringSync(outputJson);
  print("Processos convertidos e salvos em: $outputFilePath");
}

String? _getValue(
  List<dynamic> row,
  Map<String, int> headerIndex,
  String headerName,
) {
  final index = headerIndex[headerName];
  if (index != null && row.length > index && row[index] != null) {
    return row[index].toString().trim();
  }
  return null;
}

Future<void> main() async {
  print("Iniciando a conversão de CSV para JSON para o Firestore...");

  final outputDir = Directory(outputFolder);
  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  await convertSectors();
  await convertProcesses();
  print("Conversão concluída. Verifique a pasta '$outputFolder'.");
}
