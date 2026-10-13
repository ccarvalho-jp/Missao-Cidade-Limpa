# Missão Cidade Limpa

Jogo educativo mobile feito em Godot para crianças do 5º ano. A Tuca, uma tartaruga parceira, acompanha a criança enquanto ela aprende a separar resíduos e cuidar do oceano.

> **Status:** protótipo jogável. O código e a exportação Web estão no repositório; um APK de teste está disponível na página de Releases.

## Como jogar no computador

1. Instale o [Godot 4.7.2](https://godotengine.org/download/).
2. Abra `project.godot` no Godot.
3. Execute com **F6** para testar a cena principal ou **F5** para iniciar o projeto.
4. Na Fase 1, arraste cada resíduo para a lixeira correspondente. No celular, toque e arraste.
5. Ao terminar, escolha **Jogar Memória** e selecione uma dificuldade.

## Fases

### Fase 1 — Separação

A cada rodada, o jogo sorteia 10 itens, com dois de cada categoria:

| Resíduo | Lixeira |
|---|---|
| Plástico | Vermelha |
| Papel | Azul |
| Metal | Amarela |
| Vidro | Verde |
| Orgânico | Marrom |

Há 30 ilustrações de resíduos para variar as rodadas. Quando a criança erra, Tuca dá uma dica sobre a lixeira correta.

### Fase 2 — Memória do Mar

Vire duas cartas por vez e encontre os pares. As cartas reveladas mostram a ilustração e o nome do resíduo; ao encontrar um par, aparece uma dica educativa.

- **Fácil:** 4 pares (8 cartas)
- **Médio:** 8 pares (16 cartas)
- **Difícil:** 12 pares (24 cartas)

Não há cronômetro. No nível difícil, a grade pode ser rolada verticalmente em telas menores.

## Exportar para Android

1. No Godot, instale os modelos em **Editor → Gerenciar modelos de exportação**. Use os modelos correspondentes à versão do editor.
2. Instale/configure o Android SDK e um JDK compatível em **Editor → Configurações do Editor → Exportar → Android**.
3. Abra **Projeto → Exportar…**, adicione um preset **Android** e configure um identificador de pacote único, como `com.seunome.missaopraialimpa`.
4. Exporte **APK** para instalar e testar no aparelho. Para a Play Store, configure uma assinatura de lançamento e exporte **AAB**.

Não compartilhe a chave de assinatura nem senhas de publicação.

## Exportar para Web e publicar no Vercel

1. Instale os modelos de exportação do Godot, incluindo **Web**.
2. Em **Projeto → Exportar…**, adicione um preset **Web** e exporte para `web-build/index.html`.
3. Confira que `web-build/` contém `index.html` e os arquivos `.wasm`, `.js` e `.pck` gerados pelo Godot.
4. Crie/importa o repositório no Vercel com este projeto como raiz. O `vercel.json` configura `web-build` como diretório de saída; não é necessário comando de build para servir o conteúdo exportado.
5. Publique pelo painel do Vercel ou pelo Vercel CLI. Teste a URL em computador e celular.

O repositório GitHub guarda o código-fonte Godot. O diretório `web-build/` é a exportação que o Vercel entrega ao navegador; ele só estará pronto depois da exportação Web no Godot.

## Baixar o APK

O APK Android para teste é publicado na página [Releases](https://github.com/ccarvalho-jp/Missao-Cidade-Limpa/releases/latest). Baixe `MissaoCidadeLimpa.apk` em um aparelho Android e autorize a instalação quando o sistema pedir. O APK inclui suporte ARMv7 e ARM64; por ser uma versão de teste/debug, o Android pode mostrar um aviso de segurança.

Depois que a implantação Web for criada no Vercel, confirme se a URL corresponde a `https://missao-cidade-limpa.vercel.app`. Os QR codes na tela inicial apontam para esse endereço e para o APK na Release mais recente.

## Estrutura

```text
project.godot          Configuração do projeto Godot
main.tscn              Cena inicial
scripts/main.gd        Fase de separação e transição
scripts/memory_game.gd  Escolha de dificuldade e jogo da memória
assets/bins/           Ilustrações das lixeiras
assets/trash/          30 ilustrações de resíduos
assets/ui/             Tuca e verso das cartas
web-build/             Exportação Web para hospedagem (gerada pelo Godot)
```


