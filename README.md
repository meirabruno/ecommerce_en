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

#### Cadastro de Categorias



#### Criação, visualização e envio de Invoices por email

- Para criar uma nova Invoice basta estar logado e clicar no link Nova Invoice que fica acima da lista de Invoices;
- Ao clicar você vai ser direcionado para tela de criação de uma nova invoice, preencha todos os campo e clique em Cadastrar, se todos os campos estiverem corretos a invoice vai ser criada e enviada para os emails adicionados no momento da criação e você vai ser redirecionado para a visualização dessa invoice;
- Caso algum erro aconteça no momento da criação de uma invoice ele vai ser apresentado na tela e você vai precisar preencher todos os campos da invoice nomente para cadastra-la;

- Uma vez criada a invoice você pode fazer o download dela clicando no link Donwload na tela de visualização da invoice ou baixando o anexo enviado por email;
- Para acessar a tela de visualização de uma invoice não é necessário estar logado;

- Caso você seja o dono de uma invoice (foi você quem a criou) você pode enviar ela para mais emails além dos já enviados, basta acessar a visualizaçõo da invoice clicando em show na lista de invoices e um formulário vai ser apresentado no topo da tela, preencha o campo com os emails que deseja enviar e clique em Enviar, a invoice será enviada para esses novos emails e sua lista de emails será atualizada;


