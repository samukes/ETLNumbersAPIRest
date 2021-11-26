# ETL(Extract, Transform and Load) Numbers APIRest

Esta aplicação deve buscar coleção de números do endereço *http://challenge.dienekes.com.br/api/numbers?page={pagina}* de todas as páginas que forem possíveis, deve transformar o esses números fazendo um ***SORT***(ordenação) e retornar esses números ordenados em uma endpoint.

### O que utilizei para realizar o teste

- Elixir
- Phoenix
- Agent
- Tasks
- HTTPPoinson
- Poison

### Considerações

Este projeto foi bastante desafiador pelo que foi proposto, porém foi bem gratificante realiza-lo.

### Dicas de uso

- Quando o servidor estiver executando faça uma reuisição **GET** para ***url + /api/numbers***

> http://localhost:4000/api/numbers

- Derverá ser retornado um *json* contendo ***numbers*** e ***status***
