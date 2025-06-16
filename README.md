# App Base - Template Flutter

## 🚀 Criando Novo Projeto

### 1. Criar projeto Flutter básico
```bash
flutter create nome_do_app
cd nome_do_app
```

---

## 📁 Copy/Paste - Arquivos e Pastas

### ✅ **SUBSTITUIR ARQUIVO COMPLETO:**

**1. pubspec.yaml**
```bash
# Copie o pubspec.yaml do app_base e substitua o seu
```

### ✅ **COPIAR PASTA COMPLETA:**

**1. lib/**
```bash
# Delete sua pasta lib/ e copie a pasta lib/ completa do app_base
```

**2. assets/**
```bash
# Copie a pasta assets/ completa do app_base para seu projeto
```

---

## ⚙️ Configurações Nativas

### 🤖 **ANDROID**

**1. AndroidManifest.xml** (`android/app/src/main/AndroidManifest.xml`)

Copie estas linhas e cole ANTES da linha `</application>`:
```xml
        <!-- AdMob App ID - OBRIGATÓRIO para funcionamento dos anúncios -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713" />
```

**2. build.gradle.kts** (`android/app/build.gradle.kts`)

Encontre e altere:
```kotlin
compileSdk = 34  // ou maior
minSdk = 21      // ou maior
```

### 🍎 **iOS**

**1. Info.plist** (`ios/Runner/Info.plist`)

Copie estas linhas e cole ANTES da linha `</dict>`:
```xml
	<!-- AdMob App ID - OBRIGATÓRIO para funcionamento dos anúncios -->
	<key>GADApplicationIdentifier</key>
	<string>ca-app-pub-3940256099942544~1458002511</string>
```

---

## 🏃 Comandos Finais

```bash
flutter pub get
flutter run
```

---

## 📁 O que cada pasta faz

- `lib/core/` - Serviços, controllers, widgets globais
- `lib/modules/` - Telas do app (home, initial, etc.)
- `assets/locales/` - Traduções (pt.json, en.json, etc.)
- `assets/flags/` - Bandeiras dos países

//-------------------- COMO USAR NO FLUTTER ------------------//

## 💰 Sistema de Anúncios AdMob

**Como obter seus IDs**: [AdMob Console](https://admob.google.com) → Criar app → Unidades de anúncio

### 💡 **Qual Anúncio Usar?**

| Tipo | 💰 Receita | 🎯 Quando Usar |
|------|------------|-----------------|
| **🤑 Rewarded** | **ALTA** | Recompensas, moedas - **RECOMENDADO** |
| **🧠 Interstitial** | Média-Alta | Entre fases, transições |
| **📊 Banner** | Baixa-Constante | Telas com longo tempo de uso |

### 🚀 **Como Usar no Código**

```dart
import 'package:app_base/core/helpers/ad_helper.dart';

// 🤑 Rewarded (Maior lucro)
AdHelper.earnCoins(
  coinAmount: 100,
  onCoinsEarned: () {
    // Dar moedas ao usuário
  },
);

// 🧠 Interstitial
AdHelper.showInterstitialAd(
  onComplete: () {
    // Continuar para próxima tela
  },
);

// 📊 Banner
AdHelper.bannerWidget()
```

---

## 🌍 Adicionando Nova Linguagem

### 1. **Criar arquivo de tradução**
Crie em `assets/locales/`:
```json
// assets/locales/pt.json
{
  "welcome_title": "Bem-vindo",
  "continue": "Continuar",
  "theme": "Tema"
}
```

### 2. **Adicionar no main.dart**
```dart
supportedLocales: const [
  Locale('pt', 'BR'), // Português
  Locale('en', 'US'), // Inglês
  // Adicione aqui
],
```

### 3. **Usar no código**
```dart
Text(controller.languageController.getText('welcome_title'))
```

---



