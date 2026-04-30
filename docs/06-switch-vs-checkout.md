# 🔀 Switch vs Checkout en Git

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Cuál es la diferencia?

Durante mucho tiempo, Git usó un solo comando para todo:

```bash
git checkout
```

El problema: hacía demasiadas cosas.

👉 Cambiar de rama
👉 Crear ramas
👉 Restaurar archivos

Resultado: confusión garantizada.

---

## 🧠 Solución moderna

Git introdujo dos comandos más claros:

* `git switch` → para **ramas**
* `git restore` → para **archivos**

👉 Más simple, menos errores.

---

## 🔄 git switch (lo que deberías usar)

### Cambiar de rama

```bash id="switch1"
git switch main
```

---

### Crear y cambiar a una nueva rama

```bash id="switch2"
git switch -c feature/login
```

---

### Ir a una rama remota

```bash id="switch3"
git switch nombre-rama
```

👉 Git la crea localmente si existe en remoto.

---

## 📦 git checkout (el viejo multitarea)

Sigue funcionando, pero…

👉 Está sobrecargado
👉 Es fácil equivocarse

Ejemplos:

```bash id="checkout1"
git checkout main
git checkout -b feature/login
```

---

## ⚠️ Problema típico con checkout

Este comando también puede hacer esto:

```bash id="checkout2"
git checkout archivo.js
```

👉 Y acá es donde empiezan los accidentes.

Podés perder cambios sin darte cuenta.

---

## 🧩 Comparación directa

| Acción            | Comando moderno | Comando viejo     |
| ----------------- | --------------- | ----------------- |
| Cambiar rama      | `git switch`    | `git checkout`    |
| Crear rama        | `git switch -c` | `git checkout -b` |
| Restaurar archivo | `git restore`   | `git checkout`    |

---

## 🧭 Recomendación clara

👉 Usá `git switch` siempre que trabajes con ramas.
👉 Evitá `checkout` salvo que sepas exactamente lo que estás haciendo.

---

## 🧠 Regla simple

* Si hablás de **ramas** → `switch`
* Si hablás de **archivos** → `restore`

---

## ⚙️ Ejemplo típico de uso

```bash id="switch4"
git switch -c feature/login
# trabajás
git add .
git commit -m "feat: agrega login"
git switch main
git merge feature/login
```

---

## 🚫 Errores comunes

* Usar `checkout` para todo
* Borrar cambios sin querer
* No entender qué hace cada comando

---

## 🧱 Conclusión

Git evolucionó.

👉 Vos también deberías usar los comandos modernos.

Menos confusión. Más control.

---

## 🚀 Qué sigue

Ahora vamos a ver cómo usar la terminal como un pro con
**GitHub CLI**.

➡️ [Ir a GitHub CLI](07-github-cli.md)
