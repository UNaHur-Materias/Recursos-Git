# 🔄 Workflow básico de Git

[⬅ Volver al índice](../README.md)

---

## 🎯 Objetivo

Entender el flujo de trabajo mínimo para usar Git sin romper nada (o al menos, no todo 😄).

---

## 🧭 El flujo que tenés que dominar

Este es el circuito base:

```bash
git add .
git commit -m "mensaje claro"
git push
```

Pero ojo: eso es solo la superficie. Vamos paso a paso.

---

## 🧱 Paso a paso real

### 1️⃣ Modificás archivos

Trabajás normalmente en tu proyecto.

```bash
# editás archivos…
```

---

### 2️⃣ Revisás cambios

Antes de mandar cualquier cosa:

```bash
git status
```

👉 Te dice qué cambió y en qué estado está.

---

### 3️⃣ Agregás al staging

Seleccionás qué querés incluir en el commit:

```bash
git add .
```

O más fino:

```bash
git add archivo.js
```

👉 No todo cambio merece ser commit.

---

### 4️⃣ Creás el commit

```bash
git commit -m "feat: agrega login básico"
```

👉 Este es el momento clave: describí bien el cambio.

---

### 5️⃣ Subís al remoto

```bash
git push
```

👉 Sin esto, tu trabajo sigue siendo local.

---

## 🔁 Flujo completo recomendado

```bash
git status
git add .
git commit -m "mensaje claro"
git push
```

Repetir. Siempre.

---

## 🌿 Flujo correcto con ramas

No trabajes directo en `main`. Hacelo así:

```bash
git switch -c feature/login
```

Trabajás normalmente:

```bash
git add .
git commit -m "feat: agrega formulario de login"
git push -u origin feature/login
```

👉 Después se integra con Pull Request (lo vemos más adelante).

---

## ⚠️ Cosas que NO deberías hacer

❌ Trabajar directo en `main`
❌ Hacer commits gigantes
❌ No revisar con `git status`
❌ Subir código que no compila

---

## 🧠 Buen hábito

Antes de cada commit preguntate:

👉 “¿Este cambio tiene sentido por sí solo?”

Si la respuesta es “más o menos”… dividilo.

---

## 🧩 Tips prácticos

* Usá `git diff` para ver cambios en detalle
* Commit temprano, commit seguido
* Si dudás, no hagas `push` todavía

---

## 🧭 Resumen mental

* **add** → preparo
* **commit** → guardo
* **push** → comparto

Simple. Poderoso.

---

## 🚀 Qué sigue

Ahora que entendés el flujo, vamos a profundizar en algo clave: **las ramas**.

➡️ [Ir a Ramas](03-ramas.md)
