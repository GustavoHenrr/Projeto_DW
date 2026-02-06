# Data Warehouse (DW) — SQL Server

Este repositório mostra, na prática, como eu desenho e construo um **Data Warehouse no SQL Server** para consolidar dados (ERP/CRM), padronizar regras de negócio e disponibilizar **um modelo analítico em estrela (Star Schema)** pronto para reporting.

A proposta aqui é ser um projeto “end‑to‑end” com foco em **boas práticas de engenharia de dados**: organização por camadas, ETL em T‑SQL, modelagem dimensional e checagens de qualidade.

---

## 🎯 Objetivo

- Consolidar dados de vendas vindos de **múltiplas fontes** (ex.: ERP e CRM em arquivos CSV)
- Corrigir problemas comuns de qualidade (tipos, duplicidades, padronização, chaves ausentes)
- Entregar um **modelo único e consistente** para consumo analítico (BI / dashboards / queries)
- Documentar o modelo e o fluxo para facilitar manutenção e evolução

> Escopo: o pipeline trabalha com o **dataset mais recente** (sem historização/SCD por padrão).  
> Caso você queira, há espaço para evoluir para SCD Type 2 e cargas incrementais.

---

## 🧱 Arquitetura de Dados

O DW segue uma abordagem em camadas (estilo “Medallion”), separando ingestão, refinamento e consumo analítico:

- **Bronze (Raw/Staging)**  
  Dados brutos carregados “as‑is” a partir das fontes (CSV).  
  Objetivo: rastreabilidade e repetibilidade da carga.

- **Silver (Cleansed/Conformed)**  
  Normalização de tipos, limpeza de registros, padronização e conformidade entre fontes.  
  Objetivo: garantir consistência para a modelagem.

- **Gold (Analytics / Star Schema)**  
  Tabelas dimensionais e fato, com chaves substitutas, granularidade definida e otimizações.  
  Objetivo: performance e simplicidade para análises.

Se você tiver o diagrama no repositório, ele será exibido aqui:  
![Arquitetura](docs/data_architecture.png)

---

## 🧰 Stack e Ferramentas

- **SQL Server** (Express/Developer) + **SSMS**
- **T‑SQL** para ETL, modelagem e validações
- **Git/GitHub** para versionamento
- **Draw.io** para diagramas (arquitetura, fluxo, modelo)

Links úteis:
- SQL Server: https://www.microsoft.com/sql-server/sql-server-downloads  
- SSMS: https://learn.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms

---

## ✅ O que este projeto demonstra

### 1) Ingestão & ETL (T‑SQL)
- Importação de CSV para staging
- Cargas idempotentes (reexecutáveis sem “sujar” o DW)
- Tratamento de tipos, valores inválidos, chaves e duplicidades

### 2) Modelagem Dimensional (Star Schema)
- **Dimensões** (ex.: cliente, produto, calendário, canal)
- **Fato** (ex.: vendas) com métricas e granularidade definida
- Chaves substitutas (surrogate keys) e integridade

### 3) Qualidade e Governança
- Regras de naming, organização por schemas/pastas
- Checks básicos (contagens, nulos, chaves órfãs)
- Documentação do catálogo e do modelo

### 4) Analytics (SQL)
- Consultas analíticas prontas para:
  - tendências de vendas
  - performance por produto/categoria
  - comportamento de clientes
  - comparativos por período

---

## 🚀 Como executar localmente

### Pré‑requisitos
1. Instale **SQL Server** (Express ou Developer)
2. Instale **SQL Server Management Studio (SSMS)**
3. Clone o repositório e verifique se a pasta `datasets/` possui os arquivos CSV

### Passo a passo (ordem recomendada)
1. **Criar banco e schemas**
   - `scripts/00_setup/` (criação do banco, schemas, tabelas iniciais)

2. **Carregar Bronze (staging/raw)**
   - `scripts/bronze/`
   - (Opcional) ajuste caminhos/nomes dos arquivos no script de carga

3. **Transformar Silver (cleansed/conformed)**
   - `scripts/silver/`
   - limpeza, padronização e conformação entre fontes

4. **Construir Gold (modelo analítico)**
   - `scripts/gold/`
   - criação do Star Schema (dims + fact) e views para consumo

5. **Validar**
   - `tests/` (checagens e queries de validação)

---

## 🗂️ Estrutura do repositório

```
data-warehouse-sqlserver/
│
├── datasets/                           # Datasets brutos (CSV)
│
├── docs/                               # Documentação e diagramas
│   ├── data_architecture.png           # Arquitetura (imagem)
│   ├── data_flow.drawio                # Fluxo de dados
│   ├── data_models.drawio              # Modelo dimensional (estrela)
│   ├── data_catalog.md                 # Catálogo de dados (campos e descrições)
│   └── naming-conventions.md           # Padrões de nomenclatura
│
├── scripts/
│   ├── 00_setup/                       # Setup do banco, schemas e objetos base
│   ├── bronze/                         # Carga RAW (staging)
│   ├── silver/                         # Transformações e conformação
│   └── gold/                           # Star Schema e camada analítica
│
├── tests/                              # Queries e checks de qualidade
│
├── README.md
└── LICENSE
```

---

## 🧠 Notas de implementação (decisões de projeto)

- **Granularidade da Fato**: (ex.: 1 linha por item de pedido / por transação / por dia)  
- **Dimensão Calendário**: essencial para análises por período e comparativos
- **Performance**: índices/particionamento podem ser adicionados na camada Gold conforme volume
- **Orquestração** (opcional): SQL Server Agent / pipelines externos (Airflow/ADF) para agendamento

> Se você for usar este repositório como portfólio, personalize o dataset e descreva as decisões (trade‑offs) no histórico do Git.

---

## 📌 Próximos passos (ideias de evolução)

- Cargas incrementais (watermark) e tratamento de late‑arriving data
- SCD Type 2 para dimensões críticas
- Procedure de carga com logging e auditoria
- Camada de consumo com views versionadas para BI

---

## 🧾 Licença

Este projeto é distribuído sob a licença **MIT** (veja `LICENSE`).

---

## 👤 Autor

Gustavo Henrique  
Email: gustavohenrique063@gmail.com
LinkedIn: www.linkedin.com/in/gustavohhenr
