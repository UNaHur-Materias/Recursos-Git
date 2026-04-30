# 🔐 Autenticación en Git: SSH vs Token

[⬅ Volver al índice](../README.md)

---

## 🎯 ¿Por qué hace falta autenticarse?

Cuando trabajás con repositorios remotos (por ejemplo en GitHub), Git necesita verificar quién sos.

👉 Para:

* hacer `push`
* clonar repos privados
* crear PRs

---

## 🧠 Dos formas principales

1. 🔑 **SSH (recomendado)**
2. 🔒 **Token (HTTPS)**

---

## 🔑 SSH (la opción cómoda)

### ✔ Ventajas

* No pide credenciales cada vez
* Más rápido en el día a día
* Ideal para uso frecuente

---

### ⚙️ Configuración básica

#### 1. Generar clave

```bash id="ssh1"
ssh-keygen -t ed25519 -C "tu_email@ejemplo.com"
```

---

#### 2. Iniciar el agente SSH

```bash id="ssh2"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

#### 3. Copiar clave pública

```bash id="ssh3"
cat ~/.ssh/id_ed25519.pub
```

---

#### 4. Agregarla en GitHub

Ir a:
👉 Settings → SSH and GPG keys

---

#### 5. Probar conexión

```bash id="ssh4"
ssh -T git@github.com
```

---

### 📌 Usar SSH en repos

Ejemplo de URL:

```bash id="ssh5"
git@github.com:usuario/repo.git
```

---

## 🔒 Token (HTTPS)

Desde 2021, GitHub no permite usar contraseña.

👉 Se usa un **Personal Access Token (PAT)**.

---

### ✔ Cuándo usarlo

* No podés usar SSH
* Entornos restringidos
* Scripts automatizados

---

### ⚙️ Cómo generarlo

En GitHub:

👉 Settings → Developer settings → Personal access tokens

* Elegís permisos
* Generás token
* Lo copiás (no se vuelve a mostrar)

---

### 📌 Uso típico

```bash id="token1"
git clone https://github.com/usuario/repo.git
```

Cuando te pide contraseña:

👉 Pegás el token

---

## ⚠️ Errores comunes

* ❌ Usar contraseña en vez de token
* ❌ No configurar SSH correctamente
* ❌ Perder el token (hay que regenerarlo)
* ❌ No dar permisos adecuados

---

## 🧭 Comparación rápida

| Método | Comodidad | Seguridad | Uso recomendado   |
| ------ | --------- | --------- | ----------------- |
| SSH    | Alta      | Alta      | Uso diario        |
| Token  | Media     | Alta      | Casos específicos |

---

## 🧠 Recomendación clara

👉 Usá SSH si estás trabajando en tu máquina personal.
👉 Usá Token si no tenés alternativa.

---

## 🧱 Consejo práctico

Configurá SSH **una vez** y te olvidás del tema.

👉 Es de esas cosas que al principio molestan…
pero después te ahorran tiempo todos los días.

---

## 🚀 Qué sigue

Para cerrar, vamos a ver un resumen de **buenas prácticas** que te van a evitar dolores de cabeza trabajando con Git.

➡️ [Ir a Buenas prácticas](09-buenas-practicas.md)
