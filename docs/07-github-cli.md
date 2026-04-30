# 🧰 GitHub CLI (gh)

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Qué es GitHub CLI?

La **GitHub CLI** (`gh`) es una herramienta oficial para interactuar con GitHub desde la terminal.

👉 Te evita ir al navegador para tareas comunes.

---

## 🧠 Idea clave

Con `gh` podés:

* Crear repositorios
* Clonar proyectos
* Manejar Pull Requests
* Autenticarte
* Administrar issues

Todo sin salir de la consola.

---

## ⚙️ Instalación

Según tu sistema:

* Windows → `winget install GitHub.cli`
* Mac → `brew install gh`
* Linux → paquetes oficiales

Verificar instalación:

```bash id="gh1"
gh --version
```

---

## 🔐 Login

Primero, autenticación:

```bash id="gh2"
gh auth login
```

Te guía paso a paso:

* Elegís GitHub.com
* HTTPS o SSH
* Login vía navegador

👉 Recomendado: SSH (más cómodo a largo plazo)

---

## 📦 Crear un repositorio

```bash id="gh3"
gh repo create
```

Modo rápido:

```bash id="gh4"
gh repo create mi-repo --public --source=. --remote=origin --push
```

👉 Esto:

* crea el repo en GitHub
* conecta el remoto
* hace push inicial

---

## ⬇️ Clonar repos

```bash id="gh5"
gh repo clone usuario/repo
```

👉 Más corto que usar `git clone`.

---

## 🔀 Pull Requests

Crear PR:

```bash id="gh6"
gh pr create
```

Ver PRs:

```bash id="gh7"
gh pr list
```

Checkout de un PR:

```bash id="gh8"
gh pr checkout 123
```

---

## 🧾 Issues

Crear issue:

```bash id="gh9"
gh issue create
```

Listar:

```bash id="gh10"
gh issue list
```

---

## 🔍 Ver info del repo

```bash id="gh11"
gh repo view
```

Abrir en navegador:

```bash id="gh12"
gh repo view --web
```

---

## ⚡ Flujo típico con gh

```bash id="gh13"
git switch -c feature/nueva-funcionalidad
# trabajás
git add .
git commit -m "feat: nueva funcionalidad"
git push -u origin feature/nueva-funcionalidad

gh pr create
```

👉 Terminal + GitHub integrados.

---

## ⚠️ Errores comunes

* No hacer `gh auth login`
* No tener permisos en el repo
* Confundir `gh` con `git` (son complementarios)

---

## 🧠 Cuándo usar gh

Usalo cuando:

✔ Trabajás mucho en terminal
✔ Querés velocidad
✔ Evitás el navegador

No es obligatorio, pero:

👉 Cuando te acostumbrás, no volvés atrás.

---

## 🧱 Consejo práctico

Para alumnos:

* Primero Git básico
* Después `gh`

👉 Si no entienden Git, `gh` no los salva.

---

## 🚀 Qué sigue

Ahora vamos a ver algo clave para poder trabajar con repos remotos sin problemas:

🔐 autenticación con **SSH y Token**

➡️ [Ir a Autenticación](08-auth.md)
