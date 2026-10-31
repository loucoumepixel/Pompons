#!/bin/sh
# Lancement façon Atelier des Maîtres : l'écran de démarrage d'Android est une crème unie, sans icône,
# exactement la couleur sur laquelle l'intro Loucoume Interactive commence. Plus d'icône du jeu
# (Android 12 et plus, tablettes comprises), plus de fond sombre en mode nuit, plus de bande grise.
# Lancé par le workflow après « npm run android », depuis le dossier du jeu.
set -e
RES=android/app/src/main/res
mkdir -p $RES/values $RES/values-night $RES/values-v31 $RES/drawable
cat > $RES/values/demarrage_couleurs.xml <<'X'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="creme_demarrage">#FFF6EF</color>
</resources>
X
cp $RES/values/demarrage_couleurs.xml $RES/values-night/demarrage_couleurs.xml
# icône vide : Android exige une icône sur l'écran de démarrage, on lui en donne une transparente
cat > $RES/drawable/demarrage_vide.xml <<'X'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <solid android:color="@android:color/transparent" />
    <size android:width="108dp" android:height="108dp" />
</shape>
X
STYLES='
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
    </style>

    <style name="AppTheme.NoActionBar" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="windowActionBar">false</item>
        <item name="windowNoTitle">true</item>
        <item name="android:background">@null</item>
        <item name="android:windowBackground">@color/creme_demarrage</item>
        <item name="android:statusBarColor">@color/creme_demarrage</item>
        <item name="android:navigationBarColor">@color/creme_demarrage</item>
        <item name="android:windowLightStatusBar">true</item>
    </style>
'
cat > $RES/values/styles.xml <<X
<?xml version="1.0" encoding="utf-8"?>
<resources>
$STYLES
    <style name="AppTheme.NoActionBarLaunch" parent="Theme.SplashScreen">
        <item name="windowSplashScreenBackground">@color/creme_demarrage</item>
        <item name="windowSplashScreenAnimatedIcon">@drawable/demarrage_vide</item>
        <item name="postSplashScreenTheme">@style/AppTheme.NoActionBar</item>
        <item name="android:windowBackground">@color/creme_demarrage</item>
    </style>
</resources>
X
cat > $RES/values-v31/styles.xml <<X
<?xml version="1.0" encoding="utf-8"?>
<resources>
$STYLES
    <style name="AppTheme.NoActionBarLaunch" parent="Theme.SplashScreen">
        <item name="windowSplashScreenBackground">@color/creme_demarrage</item>
        <item name="windowSplashScreenAnimatedIcon">@drawable/demarrage_vide</item>
        <item name="postSplashScreenTheme">@style/AppTheme.NoActionBar</item>
        <item name="android:windowBackground">@color/creme_demarrage</item>
        <item name="android:windowSplashScreenBackground">@color/creme_demarrage</item>
        <item name="android:windowSplashScreenAnimatedIcon">@drawable/demarrage_vide</item>
        <item name="android:windowSplashScreenIconBackgroundColor">@color/creme_demarrage</item>
    </style>
</resources>
X
grep -c creme_demarrage $RES/values/styles.xml $RES/values-v31/styles.xml
