# Como contribuir

Quando quiser contribuir com este repositório, por favor, antes discuta a mudança que deseja fazer enviando a questão com o proprietário do repositório antes de efetivar a mudança. Correções de digitação ou de refraseamento para melhor compreensão NÃO requerem discussão com o proprietário.

## Modelo de *branching*

Este repositório mantém dois *branches* principais com um tempo de vida indefinido:
* `master` é o *branch* padrão e que portanto reflete a última *release*.
* `develop` é o *branch* padrão refletindo as últimas modificações para o próximo *release*. Quando o *branch* `develop` alcança um estágio estável e está pronto para liberação de uma versão nova e final, todas as modificações desde são unificadas de volta no *branch* `master`.

Uma variadade de *branches* de suporte são utilizadas para cuidar de desenvolvimentos paralelos. Estes tipos de *branches* possuem um tempo de vida limitado, até serem eventualmente e definitivamente removidos.

## Contribuindo

Contribuições a este repositório são bem-vindas. Para facilitar o gerencialmente, por favor, siga os passos abaixo descritos:

1. Faça o *fork* do repositório na sua conta.

2. Faça o clone desse repositório localmente.
   ```
   git clone https://github.com/YOU/API-Security.git
   ```
3. Crie um novo *branch* baseado no `develop` do projeto original. (Ex.: `fix/foreword-section`)
   ```
   git checkout develop && git checkout -b fix/foreword-section
   ```
4. Aplique suas modificações conforme necessário.

   Por favor, sempre tenha atenção para seguir nossa convenção de estilos.

   Embora exista um arquivo [`.editorconfig`][1] na raíz do repositório, seu editor pode talvez não suportá-lo. Para aprender mais sobre o [EditorConfig][2] e o suporte a IDEs e editores, consulta o website: https://editorconfig.org/.

5. Faça o commit da suas mdificações.

   1. Verifique os arquivos modificados e adicione apenas estes (ex.: artefatos de compilação NÃO DEVEM estar sob controle de versão).
   2. A primeira linha da mensagem de *commit* deve informar uma breve descrição das modificações. Você pode detalhar melhor as mudanças no corpo do *commit*.

6. Faça o *push* das mudanças para seu repositório público.
   ```
   git push origin fix/foreword-section
   ```
7. Abra um *pull request* do seu *branch* `fix/foreword-section` para o *branch* `develop` do repositório original do projeto.

[1]: https://github.com/OWASP/API-Security/blob/master/.editorconfig
[2]: https://editorconfig.org/
