# Bíblia App (Leitor Pessoal com Anotações)

Fundação do projeto Flutter com arquitetura offline-first.

## Stack
- Flutter
- Drift (SQLite) com `sqlite3_flutter_libs`
- MobX (com `build_runner` e `mobx_codegen`)
- Dio (HTTP)

## Banco de Dados (Schema)
- `traducoes (id, nome, sigla, idioma)`
- `livros (id, nome, testamento)`
- `versiculos (id autoincrement, traducao_id FK, livro_id FK, capitulo, numero_versiculo, texto)`
  - Unique: `(traducao_id, livro_id, capitulo, numero_versiculo)`

Implementação: `lib/data/app_database.dart`

## API Bible
- Endpoint: `https://rest.api.bible`
- Defina a chave via `--dart-define`.

Exemplo de execução:

```
flutter run \
  --dart-define=API_BIBLE_KEY=mBRApjy5NtitrUSQxItkr
```

## Gerar arquivos de código

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Próximos passos
- Criar serviços para download e persistência das traduções e livros
- Implementar stores MobX por feature (leitura, busca, anotações)
- Desenho livre e destaques com suporte a stylus
