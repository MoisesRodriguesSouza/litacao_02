import pandas as pd
import json
import os
from datetime import datetime

# --- Configurações ---
CSV_FOLDER = 'data' # Crie uma pasta 'data' na raiz do seu projeto e coloque os CSVs lá
OUTPUT_FOLDER = 'firestore_data' # Pasta onde os ficheiros JSON serão salvos

SECTORS_CSV_FILE = 'sectors.csv'
PROCESSES_CSV_FILE = 'processes.csv'

# Certifique-se de que as pastas de entrada e saída existem
if not os.path.exists(CSV_FOLDER):
    print(f"Erro: A pasta '{CSV_FOLDER}' não foi encontrada. Por favor, crie-a e coloque os ficheiros CSV lá.")
    exit()

if not os.path.exists(OUTPUT_FOLDER):
    os.makedirs(OUTPUT_FOLDER)

# --- Mapeamento de Setores (para obter IDs) ---
# Este mapeamento é crucial para vincular os processos aos setores corretos.
# Idealmente, você importaria os setores primeiro e obteria os IDs gerados pelo Firestore,
# mas para este script, usaremos os IDs que definimos no Canvas 'Dados para sectors.csv'.
sector_name_to_id = {
    "GABINETE DO SECRETÁRIO": "gabinete_secretario",
    "RECEPÇÃO / PROTOCOLO": "recepcao_protocolo",
    "COORDENADOR DE ATIVIDADES ADMINISTRATIVAS DO GABINETE DO SECRETÁRIO": "coord_ativ_adm_gabinete",
    "CHEFIA DE GABINETE": "chefia_gabinete",
    "SUBSECRETÁRIO(A) MUNICIPAL DE EDUCAÇÃO": "subsecretario_educacao",
    "ASSESSORIA TÉCNICA DE LICITAÇÃO PRESIDENTE DA CL": "ass_tec_licitacao",
    "ASSESSORIA TÉCNICA JURÍDICA EDUCACIONAL": "ass_tec_juridica",
    "ASSESSORIA TÉCNICA PARA CONTROLADORIA INTERNA DA EDUCAÇÃO": "ass_tec_controladoria",
    "COORDENAÇÃO DE CONTROLE INTERNO E ACOMPANHAMENTO DA EXECUÇÃO ORÇAMENTÁRIA": "coord_controle_interno",
    "COORDENAÇÃO DE OUVIDORIA": "coord_ouvidoria",
    "ASSESSORIA JURÍDICA": "assessoria_juridica",
    "COORDENAÇÃO DE PLANEJAMENTO DE COMPRAS": "coord_planej_compras",
    "COORDENAÇÃO DE REGISTRO E PESQUISA DE PREÇOS": "coord_reg_pesquisa_precos",
    "DIRETORIA ADMINISTRATIVA": "diretoria_administrativa",
    "SUBSECRETARIA ADJUNTA ADMINISTRATIVA": "subsec_adj_administrativa",
    "SUBSECRETARIA ADJUNTA DE ASSUNTOS EDUCACIONAIS": "subsec_adj_ass_educacionais",
    "DIRETORIA DO DEPARTAMENTO PEDAGÓGICO": "diretoria_depto_pedagogico",
    "COORDENAÇÃO DE ED. INFANTIL": "coord_ed_infantil",
    "COORDENAÇÃO DE APOIO DO CICLO DE ALFABETIZAÇÃO": "coord_apoio_alfabetizacao",
    "COORDENAÇÃO DE APOIO DOS ANOS INICIAIS 3º AO 5º ANO": "coord_apoio_anos_iniciais",
    "COORDENAÇÃO DE APOIO DOS ANOS FINAIS 6º AO 9º ANO": "coord_apoio_anos_finais",
    "COORDENAÇÃO DE EJA": "coord_eja",
    "COORDENAÇÃO DE AVALIAÇÃO DA APRENDIZAGEM": "coord_avaliacao_aprendizagem",
    "COORDENAÇÃO DE ESPORTES E ARTE": "coord_esportes_arte",
    "COORDENAÇÃO DE APOIO A PROGRAMAS ESPECIAIS DO MEC": "coord_apoio_prog_mec",
    "COORDENAÇÃO DE APOIO DE EDUCAÇÃO INTEGRAL": "coord_apoio_ed_integral",
    "DIRETORIA DE CENSO E MATRÍCULAS": "diretoria_censo_matriculas",
    "COORDENAÇÃO DE APOIO DE REGISTRO E CONTROLE ACADÊMICO": "coord_apoio_reg_acad",
    "COORDENADOR DE APOIO A PERMANÊNCIA ESTUDANTIL": "coord_apoio_permanencia",
    "DIRETORIA DE ATENDIMENTO EDUCACIONAL ESPECIALIZADO": "diretoria_atend_educ_esp",
    "COORDENAÇÃO DE EDUCAÇÃO ESPECIAL": "coord_educacao_especial",
    "DIRETORIA DE SUPERVISÃO E ACOMPANHAMENTO DA GESTÃO ESCOLAR": "diretoria_supervisao_gestao",
    "COORDENAÇÃO DE APOIO DE SUPERVISÃO ESCOLAR": "coord_apoio_supervisao",
    "CONSELHO MUNICIPAL DE EDUCAÇÃO": "conselho_municipal_educacao",
    "DIRETORIA DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO DA EDUCAÇÃO": "diretoria_planej_orc_fin",
    "DIRETORIA DE CONTROLE E EXECUÇÃO ORÇAMENTÁRIA E FINANCEIRA DA EDUCAÇÃO": "diretoria_controle_exec_orc",
    "COORDENAÇÃO DE CONTABILIDADE, ORÇAMENTO E FINANÇAS": "coord_contabilidade_orc_fin",
    "ASSESSOR DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO": "assessor_planej_orc_fin",
    "ASSESSOR DE CONTROLE E EXECUÇÃO ORÇAMENTÁRIA E FINANCEIRA": "assessor_controle_exec_orc",
    "DEPARTAMENTO FINANCEIRO": "departamento_financeiro",
    "ASSESSORIA TÉCNICA CONTÁBIL": "assessoria_tec_contabil",
    "SUBSECRETARIA ADJUNTA FINANCEIRA": "subsecretaria_adj_financeira",
    "COORDENAÇÃO DE PRESTAÇÃO DE CONTAS": "coord_prestacao_contas",
    "ASSESSORIA TÉCNICA PARA SUPERINTENDÊNCIA DO FUNDO MUNICIPAL DE EDUCAÇÃO": "ass_tec_superint_fme",
    "DIRETORIA DE INFRAESTRUTURA": "diretoria_infraestrutura",
    "COORDENAÇÃO DE MANUTENÇÃO": "coord_manutencao",
    "COORDENAÇÃO DE PROJETOS DE INFRAESTRUTURA": "coord_projetos_infraestrutura",
    "ASSESSORIA TÉCNICA DE INFRAESTRUTURA": "assessoria_tec_infraestrutura",
    "SUBSECRETARIA ADJUNTA DE INFRAESTRUTURA": "subsecretaria_adj_infraestrutura",
    "ASSESSOR DE MANUTENÇÃO - EDIFICAÇÕES": "assessor_manutencao_edif",
    "Subsecretaria Adjunta de Inovação e Tecnologia SEMED": "subsecretaria_adj_inovacao_tecnologia",
    "SUBSECRETARIA ADJUNTA ADMINISTRATIVA SEMED": "subsecretaria_adj_administrativa_semed",
    "ASSESSORIA TÉCNICA / SEMED": "assessoria_tecnica_semed",
    "DIRETORIA DE PLANEJAMENTO ORÇAMENTÁRIO E FINANCEIRO": "diretoria_de_planejamento_orcamentario_financeiro",
    "DIRETORIA DE INFRAESTRUTURA SEMED": "diretoria_de_infraestrutura_semed",
    "SUBSECRETARIA ADJUNTA DE ASSUNTOS EDUCACIONAIS SEMED": "subsecretaria_adjunta_de_assuntos_educacionais_semed",
    "DIRETORIA DE ATENDIMENTO EDUCACIONAL ESPECIALIZADO SEMED": "diretoria_de_atendimento_educacional_especializado_semed",
    "DIRETORIA DE SUPERVISÃO E ACOMPANHAMENTO DA GESTÃO ESCOLAR SEMED": "diretoria_de_supervisao_e_acompanhamento_da_gestao_escolar_semed",
    "CONSELHO MUNICIPAL DE EDUCAÇÃO SEMED": "conselho_municipal_de_educacao_semed",
    # Adicione outros setores conforme necessário
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
    "Secretaria de Agricultura": "secretaria_de_agricultura"
}

# Mapeamento de Assessores (simplificado, idealmente viria de uma coleção 'users')
# Para uma importação inicial, podemos usar os nomes como IDs temporários.
assessor_name_to_id = {
    "GUILHERME": "guilherme_uid",
    "João Silva": "joao_silva_uid",
    "Maria Souza": "maria_souza_uid",
    "Carlos Pereira": "carlos_pereira_uid",
    "Ana Santos": "ana_santos_uid",
    "Lucas Ferreira": "lucas_ferreira_uid",
    # Adicione outros assessores conforme necessário
}

# --- Função para converter e importar setores ---
def convert_sectors():
    try:
        df_sectors = pd.read_csv(os.path.join(CSV_FOLDER, SECTORS_CSV_FILE))
        sectors_data = {}
        for index, row in df_sectors.iterrows():
            sector_name = row['name (Nome do Setor)']
            sector_id = sector_name_to_id.get(sector_name, sector_name.lower().replace(' ', '_').replace('/', '_').replace('(', '').replace(')', ''))
            sectors_data[sector_id] = {
                "name": sector_name,
                "code": row['code (Código)'],
                "active": True
            }
        
        output_path = os.path.join(OUTPUT_FOLDER, 'sectors.json')
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(sectors_data, f, ensure_ascii=False, indent=2)
        print(f"Sectores convertidos e salvos em: {output_path}")
    except FileNotFoundError:
        print(f"Erro: O ficheiro '{SECTORS_CSV_FILE}' não foi encontrado na pasta '{CSV_FOLDER}'.")
    except Exception as e:
        print(f"Erro ao converter setores: {e}")

# --- Função para converter e importar processos ---
def convert_processes():
    try:
        df_processes = pd.read_csv(os.path.join(CSV_FOLDER, PROCESSES_CSV_FILE))
        processes_data = {}
        for index, row in df_processes.iterrows():
            # Gerar um ID único para o documento do processo no Firestore
            process_id = f"process_{row['processNumber'].replace('/', '_').replace('.', '_')}_{index}"

            # Mapear e limpar dados
            object_description = row['objectDescription'].strip() if pd.notna(row['objectDescription']) else ""
            
            # Mapear sectorId
            raw_sector_name = row['sectorId'].strip() if pd.notna(row['sectorId']) else ""
            sector_id = sector_name_to_id.get(raw_sector_name, raw_sector_name.lower().replace(' ', '_').replace('/', '_').replace('(', '').replace(')', ''))
            
            # Mapear assessorId
            raw_assessor_name = row['assessorId'].strip() if pd.notna(row['assessorId']) else ""
            assessor_id = assessor_name_to_id.get(raw_assessor_name, raw_assessor_name.lower().replace(' ', '_'))

            # Inferir contractType (simplificado)
            contract_type = "Outro"
            if "serviço" in object_description.lower() or "serviço" in (row['modality'] or "").lower():
                contract_type = "Serviço"
            elif "aquisição" in object_description.lower() or "aquisição" in (row['modality'] or "").lower():
                contract_type = "Bens"
            elif "locação" in object_description.lower() or "locação" in (row['modality'] or "").lower():
                contract_type = "Locação"

            # Converter datas para formato Timestamp (string ISO 8601)
            opening_date = None
            if pd.notna(row['openingDate']) and row['openingDate'] != 'N/A':
                try:
                    # Tenta analisar a data no formato DD-MM-YYYY ou YYYY-MM-DD
                    if len(row['openingDate'].split('-')[0]) == 4: # Assume YYYY-MM-DD
                        opening_date = datetime.strptime(row['openingDate'], '%Y-%m-%d')
                    else: # Assume DD-MM-YYYY
                        opening_date = datetime.strptime(row['openingDate'], '%d-%m-%Y')
                except ValueError:
                    print(f"Aviso: Data de abertura inválida para o processo {row['processNumber']}: {row['openingDate']}")
                    opening_date = datetime.now() # Fallback para data atual
            else:
                opening_date = datetime.now() # Fallback para data atual se N/A

            last_activity_date = None
            if pd.notna(row['lastActivityDate']) and row['lastActivityDate'] != 'N/A':
                 try:
                    if len(row['lastActivityDate'].split('-')[0]) == 4: # Assume YYYY-MM-DD
                        last_activity_date = datetime.strptime(row['lastActivityDate'], '%Y-%m-%d')
                    else: # Assume DD-MM-YYYY
                        last_activity_date = datetime.strptime(row['lastActivityDate'], '%d-%m-%Y')
                 except ValueError:
                    print(f"Aviso: Data de última atividade inválida para o processo {row['processNumber']}: {row['lastActivityDate']}")
                    last_activity_date = datetime.now() # Fallback
            else:
                last_activity_date = datetime.now() # Fallback

            # Converter 'isRenewable' para booleano
            is_renewable = False
            if pd.notna(row['isRenewable']) and row['isRenewable'].lower() == 'true':
                is_renewable = True

            # Construir o documento Firestore
            doc = {
                "processNumber": str(row['processNumber']),
                "objectDescription": object_description,
                "sectorId": sector_id,
                "assessorId": assessor_id,
                "modality": row['modality'] if pd.notna(row['modality']) else "",
                "contractType": contract_type,
                "currentPhase": row['currentPhase'] if pd.notna(row['currentPhase']) else "",
                "status": row['status'] if pd.notna(row['status']) else "",
                "observations": row['observations'] if pd.notna(row['observations']) else "",
                "estimatedValue": float(row['estimatedValue']) if pd.notna(row['estimatedValue']) and row['estimatedValue'] != 'N/A' else 0.0,
                "openingDate": opening_date.isoformat() + "Z" if opening_date else None, # Formato ISO 8601 para Timestamp
                "expectedCompletionDate": None, # Não há no CSV original
                "actualCompletionDate": None, # Não há no CSV original
                "delayReason": row['delayReason'] if pd.notna(row['delayReason']) else None,
                "lastActivityDate": last_activity_date.isoformat() + "Z" if last_activity_date else None,
                "attachments": [], # Não há no CSV original
                "isRenewable": is_renewable,
                "contractId": row['contractId'] if pd.notna(row['contractId']) else None
            }
            processes_data[process_id] = doc

        output_path = os.path.join(OUTPUT_FOLDER, 'processes.json')
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(processes_data, f, ensure_ascii=False, indent=2)
        print(f"Processos convertidos e salvos em: {output_path}")
    except FileNotFoundError:
        print(f"Erro: O ficheiro '{PROCESSES_CSV_FILE}' não foi encontrado na pasta '{CSV_FOLDER}'.")
    except Exception as e:
        print(f"Erro ao converter processos: {e}")

# --- Execução do Script ---
if __name__ == "__main__":
    print("Iniciando a conversão de CSV para JSON para o Firestore...")
    convert_sectors()
    convert_processes()
    print("Conversão concluída. Verifique a pasta 'firestore_data'.")
