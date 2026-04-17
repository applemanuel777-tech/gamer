# 🎮 GamerBoost - Optimizador para iPhone

App iOS para optimizar tu iPhone antes de jugar Free Fire y otros juegos.

## ¿Qué hace la app?

- ✅ Guía de optimización paso a paso automatizada
- ✅ Tips específicos para Free Fire, PUBG, COD Mobile y más
- ✅ Monitor de batería en tiempo real
- ✅ Perfiles de configuración por juego
- ✅ Diseño oscuro estilo gamer

## Cómo instalar en tu iPhone (GRATIS)

### Paso 1 - Subir el código a GitHub
1. Crea una cuenta en [github.com](https://github.com) si no tienes
2. Crea un repositorio nuevo llamado `GamerBoost`
3. Sube todos estos archivos al repositorio

### Paso 2 - Compilar automáticamente
1. Ve a tu repositorio en GitHub
2. Haz clic en la pestaña **"Actions"**
3. Verás el workflow **"Build GamerBoost IPA"**
4. Haz clic en **"Run workflow"** → **"Run workflow"**
5. Espera ~5 minutos a que compile

### Paso 3 - Descargar el IPA
1. Cuando termine, haz clic en el workflow completado
2. Baja hasta **"Artifacts"**
3. Descarga **"GamerBoost-IPA"**
4. Extrae el archivo ZIP → tendrás `GamerBoost.ipa`

### Paso 4 - Instalar en iPhone con AltStore
1. Descarga **AltServer** en tu PC desde [altstore.io](https://altstore.io)
2. Instala **AltStore** en tu iPhone siguiendo las instrucciones del sitio
3. Abre AltStore en tu iPhone
4. Ve a **"My Apps"** → **"+"** → selecciona el archivo `GamerBoost.ipa`
5. ¡Listo! La app aparecerá en tu iPhone

> ⚠️ Con cuenta gratuita de Apple, la app expira cada 7 días.
> Abre AltStore conectado al WiFi para renovarla automáticamente.

## Estructura del proyecto

```
GamerBoost/
├── GamerBoost.xcodeproj/     # Proyecto Xcode
├── GamerBoost/
│   ├── GamerBoostApp.swift   # Punto de entrada
│   ├── ContentView.swift     # Navegación principal
│   ├── HomeView.swift        # Pantalla de inicio
│   ├── OptimizeView.swift    # Optimización automática
│   ├── ProfileView.swift     # Perfiles por juego
│   ├── Assets.xcassets/      # Recursos visuales
│   └── Info.plist            # Configuración de la app
└── .github/workflows/
    └── build.yml             # Compilación automática
```
