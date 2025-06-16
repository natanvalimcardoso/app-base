# App Base - Arquitetura MVC

## 📱 Visão Geral

Este projeto Flutter segue o padrão **Model-View-Controller (MVC)** e implementa um sistema robusto de localização/internacionalização (i18n) com suporte a 10 idiomas diferentes. A aplicação possui uma tela inicial elegante onde o usuário pode selecionar seu idioma preferido.

## 🏗️ Arquitetura do Projeto

### Padrão MVC

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
├── mvc/                               # Arquitetura MVC
│   ├── models/                        # Modelos de dados
│   │   └── language_model.dart        # Modelo para idiomas suportados
│   ├── views/                         # Interface do usuário
│   │   └── initial_screen.dart        # Tela inicial da aplicação
│   └── controllers/                   # Lógica de negócio
│       └── initial_controller.dart    # Controlador da tela inicial
└── services/                          # Serviços da aplicação
    └── localization_service.dart      # Serviço de localização
```

### Estrutura de Assets

```
assets/
├── flags/                             # Bandeiras dos países
│   ├── us.png                         # Estados Unidos (Inglês)
│   ├── es.png                         # Espanha
│   ├── tw.png                         # Taiwan (Chinês Tradicional)
│   ├── jp.png                         # Japão
│   ├── de.png                         # Alemanha
│   ├── fr.png                         # França
│   ├── br.png                         # Brasil
│   ├── ru.png                         # Rússia
│   ├── kr.png                         # Coreia do Sul
│   └── it.png                         # Itália
└── locales/                           # Arquivos de localização
    ├── en.json                        # Inglês
    ├── es.json                        # Espanhol
    ├── zh.json                        # Chinês (Tradicional)
    ├── ja.json                        # Japonês
    ├── de.json                        # Alemão
    ├── fr.json                        # Francês
    ├── pt.json                        # Português (BR)
    ├── ru.json                        # Russo
    ├── ko.json                        # Coreano
    └── it.json                        # Italiano
```

## 🎨 Componentes da Arquitetura

### 1. **Model** (`language_model.dart`)
Define a estrutura de dados para os idiomas suportados:
- Código do idioma (ISO 639-1)
- Nome nativo do idioma
- Caminho para a bandeira do país
- Lista estática de todos os idiomas suportados

### 2. **View** (`initial_screen.dart`)
Interface de usuário responsiva e moderna com:
- **Design Gradient**: Fundo degradê atrativo
- **Seletor de Idiomas**: Lista horizontal scrollável com bandeiras
- **Feedback Visual**: Estados selecionado/não selecionado
- **Botão de Ação**: "Continuar" estilizado
- **Loading States**: Indicadores de carregamento
- **Error Handling**: Fallback para bandeiras não encontradas

### 3. **Controller** (`initial_controller.dart`)
Gerencia o estado e lógica de negócio:
- **Gerenciamento de Estado**: Utiliza `ChangeNotifier`
- **Troca de Idiomas**: Lógica para alternar idiomas
- **Persistência**: Salva preferência do usuário
- **Inicialização**: Carrega idioma previamente selecionado
- **Navegação**: Método para próxima tela (placeholder)

### 4. **Service** (`localization_service.dart`)
Serviço dedicado para localização:
- **Carregamento Dinâmico**: Carrega JSONs sob demanda
- **Cache de Textos**: Mantém textos em memória
- **Persistência Local**: Usa `SharedPreferences`
- **Fallback Strategy**: Reverte para idioma padrão em caso de erro
- **API Limpa**: Interface simples para recuperar textos

## 🌍 Sistema de Localização

### Idiomas Suportados

| Idioma | Código | País | Bandeira |
|--------|--------|------|----------|
| English | `en` | Estados Unidos | 🇺🇸 |
| Español | `es` | Espanha | 🇪🇸 |
| 中文（繁體）| `zh` | Taiwan | 🇹🇼 |
| 日本語 | `ja` | Japão | 🇯🇵 |
| Deutsch | `de` | Alemanha | 🇩🇪 |
| Français | `fr` | França | 🇫🇷 |
| Português (BR) | `pt` | Brasil | 🇧🇷 |
| Русский | `ru` | Rússia | 🇷🇺 |
| 한국어 | `ko` | Coreia do Sul | 🇰🇷 |
| Italiano | `it` | Itália | 🇮🇹 |

### Estrutura dos Arquivos JSON

Cada arquivo de localização contém as seguintes chaves:

```json
{
  "app_name": "Nome da Aplicação",
  "welcome_title": "Título de Boas-vindas",
  "welcome_message": "Mensagem de boas-vindas detalhada",
  "change_language": "Alterar Idioma",
  "continue": "Continuar",
  "language_selector": "Seletor de Idioma",
  "current_language": "Nome do Idioma Atual"
}
```

## 🛠️ Tecnologias Utilizadas

### Dependências Principais
- **Flutter SDK**: `^3.8.1`
- **provider**: `^6.1.2` - Gerenciamento de estado
- **shared_preferences**: `^2.2.2` - Persistência local
- **flutter_localizations**: SDK Flutter - Suporte a localização

### Dependências de Desenvolvimento
- **flutter_lints**: `^5.0.0` - Análise de código
- **flutter_test**: SDK Flutter - Testes unitários

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Flutter SDK 3.8.1 ou superior
- Dart SDK incluído no Flutter
- Android Studio / VS Code com extensões Flutter
- Dispositivo físico ou emulador configurado

### Passos para Execução

1. **Clone o repositório**
```bash
git clone <url-do-repositorio>
cd app_base
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute a aplicação**
```bash
flutter run
```

### Comandos Úteis

```bash
# Análise de código
flutter analyze

# Formatação de código
flutter format .

# Testes
flutter test

# Build para produção (Android)
flutter build apk --release

# Build para produção (iOS)
flutter build ios --release
```

## 📱 Funcionalidades da Tela Inicial

### Interface de Usuário
- **Design Responsivo**: Adapta-se a diferentes tamanhos de tela
- **Tema Moderno**: Material Design 3 com cores personalizadas
- **Animações Suaves**: Transições elegantes entre estados
- **Acessibilidade**: Suporte para leitores de tela e navegação por teclado

### Funcionalidades Implementadas
- ✅ Seleção de idioma com preview de bandeiras
- ✅ Persistência da preferência do usuário
- ✅ Carregamento dinâmico de textos localizados
- ✅ Estados de loading e error handling
- ✅ Design responsivo e acessível

### Funcionalidades Futuras (Comentadas)
- 🔄 Navegação para próxima tela
- 🔄 Integração com sistema de autenticação
- 🔄 Sincronização com backend
- 🔄 Métricas de uso por idioma

## 🔧 Configuração e Personalização

### Adicionando Novos Idiomas

1. **Adicione a bandeira**: Coloque o PNG em `assets/flags/`
2. **Crie o arquivo JSON**: Adicione em `assets/locales/`
3. **Atualize o modelo**: Inclua na lista `supportedLanguages`
4. **Teste**: Verifique se o carregamento funciona corretamente

### Modificando Textos

1. Edite os arquivos JSON em `assets/locales/`
2. Mantenha as chaves consistentes entre todos os idiomas
3. Teste em diferentes idiomas para garantir que não há quebras

### Customizando o Visual

1. **Cores**: Modifique o `seedColor` em `main.dart`
2. **Gradiente**: Altere as cores em `initial_screen.dart`
3. **Tipografia**: Ajuste `fontFamily` no tema
4. **Layout**: Modifique espaçamentos e tamanhos conforme necessário

## 📊 Padrões de Código

### Clean Code
- **Nomes Descritivos**: Variáveis e funções com nomes claros
- **Funções Pequenas**: Responsabilidade única por método
- **Comentários Essenciais**: Apenas para lógica complexa
- **Organização**: Estrutura de pastas lógica e consistente

### Boas Práticas Flutter
- **Const Constructors**: Otimização de performance
- **Provider Pattern**: Gerenciamento de estado eficiente
- **Separation of Concerns**: MVC bem definido
- **Error Handling**: Tratamento adequado de exceções
- **Responsive Design**: Suporte a diferentes dispositivos

## 🤝 Contribuição

Para contribuir com o projeto:

1. Fork o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

**Desenvolvido com ❤️ usando Flutter**
