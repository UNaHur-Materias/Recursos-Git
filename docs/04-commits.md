# 💬 Commits en Git

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Qué es un commit?

Un **commit** es un registro de cambios en el repositorio.

👉 Es una “foto” del proyecto en un momento dado, con contexto.

---

## 🧠 Idea clave

Un commit no es “guardar por guardar”.

👉 Tiene que representar **un cambio lógico y entendible**.

---

## 🔧 Crear un commit

```bash
git add .
git commit -m "mensaje claro"
```

---

## ✍️ Cómo escribir buenos mensajes

Acá está la diferencia entre caos y profesionalismo.

### 📌 Formato recomendado

```text
tipo: descripción corta
```

Ejemplos:

```text
feat: agrega login con validación
fix: corrige error en formulario
docs: actualiza README
refactor: mejora estructura del servicio
```

---

## 🧩 Tipos más usados

* `feat` → nueva funcionalidad
* `fix` → corrección de error
* `docs` → documentación
* `refactor` → mejora interna sin cambiar comportamiento
* `style` → formato (sin lógica)
* `test` → tests

---

## ⚠️ Mensajes que NO sirven

❌ `"arreglos"`   
❌ `"cosas"`   
❌ `"update"`   
❌ `"cambios varios"`   

👉 No dicen nada. En 2 semanas no te acordás qué hiciste.

---

## 📏 Buenas prácticas

* Mensaje corto (una línea)
* En presente (`agrega`, no `agregué`)
* Claro y específico
* Sin mezclar cosas distintas

---

## 🧱 Tamaño del commit

👉 Regla simple:

**Un commit = una responsabilidad**

Ejemplos:

✔ Bien:

* “feat: agrega validación de email”
* “fix: corrige error en login”

❌ Mal:

* “feat: login + estilos + refactor + fixes varios”

---

## 🔍 Ver commits

```bash
git log
```

Más compacto:

```bash
git log --oneline
```

---

## 🔄 Modificar el último commit

Si te olvidaste algo:

```bash
git add .
git commit --amend
```

👉 Reescribe el último commit.

⚠️ No lo uses si ya hiciste `push` (podés romper historial compartido).

---

## 🧨 Deshacer commits (básico)

### Mantener cambios

```bash
git reset --soft HEAD~1
```

### Borrar cambios

```bash
git reset --hard HEAD~1
```

👉 Este último es destructivo. Usalo con criterio.

---

## 🧭 Convención recomendada (simple y efectiva)

```text
<tipo>: <descripción>
```

Sin complicarse demasiado.

Si querés subir nivel después:

* Conventional Commits
* mensajes extendidos

---

## 🧠 Consejo realista

Los commits son tu historial.

👉 Si están bien escritos:

* entendés tu código
* otros entienden tu código
* podés volver atrás sin miedo

👉 Si están mal:

* es arqueología digital

---

## 🚀 Qué sigue

Ahora que sabés cómo registrar cambios correctamente, vamos a ver cómo trabajar con **repos remotos**.

➡️ [Ir a Repos remotos](05-remotos.md)
