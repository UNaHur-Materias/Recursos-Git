# ☁️ Repositorios remotos en Git

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Qué es un repositorio remoto?

Un **repositorio remoto** es la versión de tu proyecto alojada en internet.

👉 Se usa para:

* compartir código
* colaborar
* hacer backup

Plataformas comunes:

* GitHub
* GitLab

---

## 🧠 Idea clave

Tu repo tiene dos mundos:

* 🖥️ **Local** → tu máquina
* ☁️ **Remoto** → servidor

Git sincroniza entre ambos.

---

## 🔗 Ver repos remotos

```bash id="remotos1"
git remote -v
```

👉 Normalmente vas a ver `origin`.

---

## ➕ Agregar un remoto

```bash id="remotos2"
git remote add origin URL_DEL_REPO
```

Ejemplo:

```bash id="remotos3"
git remote add origin https://github.com/usuario/repo.git
```

---

## ⬆️ Subir cambios (push)

```bash id="remotos4"
git push
```

Primera vez en una rama:

```bash id="remotos5"
git push -u origin main
```

👉 El `-u` deja configurada la relación para futuros pushes.

---

## ⬇️ Traer cambios (pull)

```bash id="remotos6"
git pull
```

👉 Hace:

* `fetch` (trae cambios)
* `merge` (los integra)

---

## 🔎 Traer sin mezclar (fetch)

```bash id="remotos7"
git fetch
```

👉 Solo descarga cambios, no los aplica.

Esto te da control.

---

## 🌿 Ver ramas remotas

```bash id="remotos8"
git branch -r
```

---

## 🔄 Traer TODAS las ramas remotas

```bash id="remotos9"
git fetch --all
git branch -r
```

👉 Esto actualiza referencias, pero:

❗ **No crea automáticamente ramas locales**

Para trabajar una rama remota:

```bash id="remotos10"
git switch nombre-rama
```

---

## 🔁 Clonar un repositorio

```bash id="remotos11"
git clone URL
```

Ejemplo:

```bash id="remotos12"
git clone https://github.com/usuario/repo.git
```

👉 Esto:

* descarga el repo
* configura `origin`
* trae ramas principales

---

## ⚠️ Problemas comunes

### ❌ “No veo ramas remotas”

👉 Solución:

```bash id="remotos13"
git fetch --all
git branch -r
```

---

### ❌ “No puedo hacer push”

Puede ser:

* falta de permisos
* autenticación mal configurada
* rama no vinculada

---

### ❌ “Me pisa cambios al hacer pull”

👉 Estás mezclando sin revisar.

Usá primero:

```bash id="remotos14"
git fetch
```

---

## 🧭 Buen flujo con remoto

```bash id="remotos15"
git fetch
git switch feature/mi-rama
git pull
# trabajás
git add .
git commit -m "feat: mejora funcionalidad"
git push
```

---

## 🧠 Concepto importante

👉 `fetch` es seguro
👉 `pull` es automático (y puede romper cosas si no sabés qué estás haciendo)

---

## 🚀 Qué sigue

Ahora vamos a aclarar una duda muy común:
la diferencia entre **switch y checkout**.

➡️ [Ir a Switch vs Checkout](06-switch-vs-checkout.md)
