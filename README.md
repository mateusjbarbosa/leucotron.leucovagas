# Leuco Vagas

O Leuco Vagas consiste em ser um aplicativo para o setor de Recursos Humanos no que se refere a divulgação e pré-seleção de candidatos para vagas de emprego.

# Observações de desenvolvimento

Para desenvolvimento do Leuco Vagas foi utilizada a biblioteca Flutter da Google (https://flutter.dev/) em sua versão *v1.12.13+hotfix.8-stable*.
A aplicação está estruturada para ser executada em dispositivos *Android 7.0+*.

# Hierarquia do app

A pasta lib, responsável por armazenar todos os pacotes relacionados ao desenvolvimento do Flutter, possui duas subpastas: core - para armazenamento das regras de negócio do app - e ui - para armazenamento das telas e componentes da interface.
A pasta core, por sua vez, possui duas pastas: models - classes da regra de negócio - e services - local onde fica a API de comunicação com o Firebase.
A pasta ui, possui duas pastas: shared - para componentes que possuem a mesma caracteristica em telas diferentes, evitando redundância de código - e views - para armazenamento de todas as telas do app.

# Desafio

Desenvolver um aplicativo capaz de armazenar informações curriculares de um candidato à vagas de emprego.

## Principais características:
- Aplicativo compatível com Sistema Operacional Android.
- Armazenamento das informações em Banco de Dados.
- Cadastro, edição, exclusão e listagem dos dados.
- Capacidade de pesquisa das informações cadastradas.

## Dados obrigatórios:
- Nome completo.
- Telefones de contato.
- E-mails de contato.
- Foto do candidato.
- Principais habilidades.

# Resultado obtido antes da entrega
- Desenvolvido em Flutter.
  - Compatível com Android.
- Armazenamento no Firebase.
- CRUD realizado.

# Não foi concluído a tempo
- Pesquisa dos dados
- Foto do candidato
