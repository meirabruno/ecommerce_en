# HuskyCode - README

EcommerceEn é a implementação de um CRUD de produtos de e-commerce, com informações básicas sobre produtos.

## Requisitos

* Ruby 3.1.0
* Rails 7.0.3
* PostgreSQL 14.1

## Como rodar

- Clone o projeto;
- Instalar versões do Ruby, Rails e PostgreSQL definidas nos Requisitos, recomendo utilizar o rvm para instalar o Ruby e o Rails;
(https://www.treinaweb.com.br/blog/gerenciar-versoes-do-ruby-com-rvm) Post é antigo mas vale a leitura :P

- Gerar o arquivo .env e adicionar as seguintes variáveis de ambiente:
AWS_ACCESS_KEY_ID
AWS_REGION
AWS_SECRET_ACCESS_KEY
S3_BUCKET_NAME
S3_PROTOCOL

- Isso é necessário para que o upload de imagens seja enviado para o S3 da AWS, caso não queira que o upload seja feito para o S3 é necessário alterar em environments > development.rb o seguinte campo:

```
config.active_storage.service = :amazon para config.active_storage.service = :local
```

- Rodar o bundle install;
- Rodar o rails db:create;
- Rodar o rails db:migrate;
- Rodar o rails s;

Pronto já pode ser usado.

## Comentários sobre a solução

Implementei todas as funcionalidades desejadas e como bônus adicionei a visão publica da loja.

Para a interface utilizei o Bootstrap por já conhecer sua estrutura e conseguir ser mais produtivo.

Adicionei a Criação e Listagem de Categorias para que elas possam ser criadas e utilizadas na criação dos Produtos.

Sobre a arquitetura, Categoria deixei como uma relação 1 para N com Produtos, onde o Produto tem uma Categoria e Categoria tem N Produtos.

Para as tags decidi salvar como um array de strings, pois acredito que seria apenas um campo para ajudar no SEO da loja.

Sobre as imagens, Produtos podem ter N imagens como solicitado e também implementei o deploy para o S3 da Amazon, basta preencher as variáveis de ambiente descritas em Como rodar

## Como utilizar o sistema

#### Categorias

Para que possa ser adicionado novos Produtos é necessário que pelo menos uma Categoria estaja cadastrada para que ela possa ser selecionada no cadastro de Produto.

Para acessar a lista de Categorias basta clicar no menu superior Categorias, aqui vão estar listadas todas as categorias já cadastradas, para adicionar uma nova categoria basta clicer em Adicionar Categoria, você vai ser redirecionado para tela de criação, basta preencher o campo Nome e clicar em Salvar.

Após clicar em Salvar você vai ser redirecionado para a Lista de Categorias e vai ser possível visualizar a nova Categoria cadastrada.

#### Produtos

Para visualizar a lista de Produtos cadastrados basta clicar em Produtos no menu superior, na lista vai ser possível visualizar todos os Produtos cadastrados.

Para cadastrar um novo Produto basta clicar em Adicionar Produto que você vai ser redirecionado para a tela de criação de Produtos. Para criar um novo Produto basta preencher os campos e clicar em Salvar.

Se tudo estiver correto após clicar em salvar será redirecionado para a lista de Produtos e vai ser possível visualizar o novo Produto cadastrado com uma mensagem de sucesso, caso algum erro aconteça no cadastro você vai continuar na tela de criação de produtos e na parte superior vai ser apresentado uma mensagem com o erro encontrado.

Uma vez na lista de Produtos é possível Buscar pelo nome do Produto, basta preencher o campo de busca e clicar em Buscar que a lista vai ser atualizada com os Produtos encontrados pela busca.

Os Produtos estão por padrão ordenados pela data de criação, sendo os mais recentes no topo da lista, para reordenar os Produtos para uma melhor visualização, basta clicar no título da coluna desejada, lembrando que pode ser ordenado por Nome do Produto (coluna Produto), Por Status e por Categoria. Ao clicar uma vez para ordenar ele vai ordenar de A-Z (asc) e clicando mais uma vez de Z-A (desc).

Outra ação possível é editar o Produto, basta clicar em Editar no produto que deseja altear e será redirecionado para a tela de edição de Produto, basta fazer as alterações desejadas e clicar em Salvar que será redirecionado para lista de Produtos em caso de sucesso e mantido na tela de edição caso algum erro ocorra e uma mensagem de erro vai ser apresentada.

Na lista de produtos se você deseja excluir um ou mais produtos, basta selecionar o checkbox dos produtos que deseja remover, ou o checkbox no header da tabela para selecionar todos os Produtos. Uma vez selecionado pelo menos 1 Produto um contador e o botão de Excluir Produto(s) vai aparecer, clicando em Excluir Produto(s) todos os produtos selecionados vão ser excluidos.

Também é possível visualizar apenas produtos Ativos ou em Rascunho, basta clicar nas abas Ativo para listar apenas os produtos Ativos e Rascunho para listar apenas os produtos em Rascunho.

#### Home

Ao acessar o sistema pela primeira vez você vai ir direto para tela Home, essa tela é uma simulação da visão publica da loja, onde os Produtos ativos são apresentados para o cliente, aqui são apresentados cards com as informações dos Produtos e ao clicar em um dos cards você será redirecionado para tela de Show do Produto, onde todas as informações cadastradas são apresentadas.


