Faz a cola com a presentation manipula as entity e usa os repository

Acho que nessa camada faz sentido ter todas as funcionalidades do sistema,
que vão criar, carregar, validar e manipular as entidades usando os serviços e repo,
para depois servir isso a camada de apresentação.  
Logo a ideia desse cara é ser uma camada isolada que expressa o funcionamento do sistema(regras de negócio) que seja fácil de testar unitariamente.
