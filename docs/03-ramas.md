# 🌿 Ramas en Git

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Qué es una rama?

Una **rama (branch)** es una línea de trabajo independiente dentro del repositorio.

👉 Te permite desarrollar sin romper lo que ya funciona.

---

## 🧠 Idea clave

Pensalo así:

* `main` → versión estable
* `feature/...` → lo que estás desarrollando
* `fix/...` → arreglos

Cada rama vive su propia historia hasta que la integrás.

---

## 📌 ¿Por qué usar ramas?

* Evitás romper producción
* Trabajás en paralelo
* Organizás mejor los cambios
* Facilitás el trabajo en equipo

---

## 🔧 Comandos básicos

### Ver ramas

```bash id="ramas1"
git branch
```

---

### Crear una rama

```bash id="ramas2"
git branch feature/login
```

---

### Crear y cambiar en un solo paso

```bash id="ramas3"
git switch -c feature/login
```

👉 Este es el que vas a usar siempre.

---

### Cambiar de rama

```bash id="ramas4"
git switch main
```

---

### Ver ramas remotas

```bash id="ramas5"
git branch -r
```

---

## ☁️ Subir una rama al remoto

```bash id="ramas6"
git push -u origin feature/login
```

👉 El `-u` deja la rama vinculada para futuros `push`.

---

## 🔄 Traer ramas remotas

```bash id="ramas7"
git fetch --all
git branch -r
```

👉 Importante:
`fetch` **no crea automáticamente las ramas locales**.

Para trabajar una rama remota:

```bash id="ramas8"
git switch nombre-rama
```

---

## 🔀 Integrar cambios (merge)

Volvés a `main`:

```bash id="ramas9"
git switch main
```

Y unís la rama:

```bash id="ramas10"
git merge feature/login
```

---

## ⚠️ Conflictos (la parte divertida)

Cuando dos ramas modifican lo mismo:

👉 Git no decide, decidís vos.

* Editás el archivo
* Elegís qué queda
* Confirmás con commit

---

## 🧱 Convenciones de nombres

Usá nombres claros y consistentes:

* `feature/login`
* `feature/registro-usuario`
* `fix/error-validacion`
* `hotfix/login-produccion`

👉 Evitá cosas como `rama1`, `cosas`, `prueba`.

---

## 🧭 Flujo recomendado

```bash id="ramas11"
git switch -c feature/nueva-funcionalidad
# trabajás
git add .
git commit -m "feat: implementa nueva funcionalidad"
git push -u origin feature/nueva-funcionalidad
```

Después:

* Pull Request
* Revisión
* Merge a `main`

---

## ❌ Errores comunes

* Trabajar todo en `main`
* No borrar ramas viejas
* Nombres confusos
* Mezclar muchos cambios en una sola rama

---

## 🧠 Regla de oro

👉 **Una rama = un objetivo claro**

Si hace más de una cosa… separalo.

---

## 🧹 Limpieza (opcional pero sano)

Borrar rama local:

```bash id="ramas12"
git branch -d feature/login
```

Borrar rama remota:

```bash id="ramas13"
git push origin --delete feature/login
```

---

## 🚀 Qué sigue

Ahora que dominás ramas, vamos a ver cómo hacer **commits de calidad** (esto marca la diferencia entre amateur y profesional).

➡️ [Ir a Commits](04-commits.md)
