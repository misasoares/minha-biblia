const String apiBibleEndpoint = 'https://rest.api.bible';
// Lê a API key via --dart-define=API_BIBLE_KEY=...
const String apiBibleKey = String.fromEnvironment('API_BIBLE_KEY');
// Modo de teste rápido: ingere apenas 1 livro
const bool subsetOneBook = bool.fromEnvironment('SUBSET_ONE_BOOK', defaultValue: false);