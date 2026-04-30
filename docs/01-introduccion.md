# 📘 Introducción a Git

[⬅ Volver al índice](../README.md)

---

## 🤔 ¿Qué es Git?

**Git** es un sistema de control de versiones distribuido.
En criollo: te permite **guardar el historial de cambios de tu código**, volver atrás cuando algo se rompe (sí, va a pasar 😄) y trabajar en equipo sin pisarse.

---

## 🎯 ¿Para qué sirve?

* Registrar cambios en archivos
* Volver a versiones anteriores
* Trabajar en paralelo con ramas
* Colaborar con otras personas
* Mantener un historial claro y trazable

---

## 🧠 Conceptos clave

Antes de tocar comandos, entendé estas ideas:

### 📦 Repositorio

Es el proyecto versionado. Puede estar:

* En tu máquina (local)
* En un servidor como GitHub (remoto)

---

### 📝 Commit

Es una “foto” de tu proyecto en un momento dado.

👉 No es guardar por guardar: tiene que representar un cambio con sentido.

---

### 🌿 Rama (branch)

Es una línea de trabajo independiente.

👉 Permite desarrollar sin romper lo que ya funciona.

---

### 🔗 Merge

Es la acción de unir cambios de una rama en otra.

---

### ☁️ Remoto

Es la versión del repo que vive en internet.

👉 Se usa para compartir y sincronizar trabajo.

---

## ⚙️ ¿Cómo funciona Git?

Git trabaja en 3 estados principales:

```text
Working Directory → Staging Area → Repository
```

### 🧪 Working Directory

Donde editás archivos.

### 📌 Staging Area

Donde preparás qué cambios vas a guardar.

### 💾 Repository

Donde Git guarda los commits (historial).

---

## 🔄 Flujo básico

Este es el circuito mínimo que tenés que dominar:

```bash
git add .
git commit -m "mensaje claro"
git push
```

👉 Traducción:

1. Preparás cambios
2. Guardás un commit
3. Lo subís al remoto

---

## 🧭 Filosofía de uso

* Hacé commits chicos y claros
* No trabajes directo en `main`
* Usá ramas para cada cambio
* Escribí mensajes que expliquen el *por qué*

---

## ⚠️ Errores comunes de principiante

* Hacer un solo commit gigante
* No usar ramas
* Mensajes tipo `"arreglos"` (inútiles)
* Subir código roto

---

## 🧱 Git no es magia

Git no adivina lo que querés hacer.

👉 Si entendés el flujo, todo empieza a tener sentido.
👉 Si copiás comandos sin entender… tarde o temprano explota.

---

## 🚀 Qué sigue

En la próxima sección vas a ver el **workflow básico** para trabajar ordenado y sin dolores de cabeza.

➡️ [Ir a Workflow básico](02-workflow.md)

---
