# 🧱 Buenas prácticas en Git

[⬅ Volver al índice](../README.md)

---

## 🎯 Objetivo

Trabajar con Git de forma ordenada, predecible y sin romper todo en el intento.

👉 Esto no es teoría: es lo que separa proyectos prolijos de caos total.

---

## 🧠 Principios básicos

* Claridad sobre velocidad
* Historial entendible
* Cambios pequeños y controlados
* Trabajo aislado en ramas

---

## 🌿 Uso de ramas

✔ Usar una rama por cada cambio
✔ No trabajar directo en `main`
✔ Nombrar correctamente:

```text id="bp1"
feature/login
fix/error-validacion
hotfix/bug-produccion
```

---

## 💬 Commits de calidad

✔ Un commit = un cambio lógico
✔ Mensajes claros:

```text id="bp2"
feat: agrega login
fix: corrige validación
```

❌ Evitar:

```text id="bp3"
arreglos
cosas
update
```

👉 Si no se entiende el commit, no sirve.

---

## 🔄 Flujo ordenado

```bash id="bp4"
git switch -c feature/nueva-funcionalidad
git add .
git commit -m "feat: nueva funcionalidad"
git push -u origin feature/nueva-funcionalidad
```

Después:

* Pull Request
* Revisión
* Merge

---

## 🔎 Revisar antes de commitear

Siempre:

```bash id="bp5"
git status
git diff
```

👉 Evitás subir cosas que no querías.

---

## ⛔ Evitar commits gigantes

❌ Mal:

* 20 archivos
* múltiples cambios mezclados

✔ Bien:

* cambios chicos
* fáciles de entender
* fáciles de revertir

---

## ☁️ Sincronización constante

✔ Hacer `pull` antes de trabajar
✔ Hacer `push` frecuente

👉 Evitás conflictos grandes.

---

## 🔐 Seguridad

✔ Usar SSH o token correctamente
✔ No subir:

* contraseñas
* claves privadas
* `.env`

👉 Usá `.gitignore`

---

## 🧹 Limpieza de ramas

Después de mergear:

```bash id="bp6"
git branch -d feature/login
git push origin --delete feature/login
```

👉 Mantener el repo limpio es parte del trabajo.

---

## ⚠️ Manejo de conflictos

* No entrar en pánico
* Leer los cambios
* Resolver con criterio

👉 Git no se equivoca: te está pidiendo decidir.

---

## 🧭 Consistencia del equipo

Si trabajás en equipo:

* Usar mismas convenciones
* Definir flujo claro
* Revisar código antes de mergear

---

## 🧠 Regla de oro

👉 **Si alguien más no entiende tu historial, hiciste mal el trabajo.**

---

## 🚫 Antipatrones (lo que NO querés ver)

* Commits sin mensaje claro
* Trabajo directo en `main`
* Ramas eternas
* Push de código roto
* Mezclar features y fixes en un mismo commit

---

## 🧱 Nivel pro (cuando quieras subir un cambio)

* Pull Requests obligatorios
* Code review
* CI/CD
* Hooks de pre-commit

---

## 🧠 Cierre

Git no es solo comandos.

👉 Es disciplina.
👉 Es comunicación.
👉 Es orden.

Si aplicás estas prácticas, evitás el 80% de los problemas.

Y eso, en sistemas… es un golazo.

---

## 🏁 Fin

Volvé al índice o explorá las secciones según necesites.

[⬆ Volver al índice](../README.md)
