# Catálogo de Productos Retail

Sistema de catálogo de productos e-commerce con búsqueda avanzada, filtros dinámicos y ordenamiento. Desarrollado con Ruby on Rails 8 y Hotwire.


## Requisitos del Sistema

Antes de comenzar, asegúrate de tener instalados los siguientes componentes:

**Ruby** 3.4.0 Instalar Ruby (https://www.ruby-lang.org/es/documentation/installation/)
**Rails** 8.0.4 Se instala con `gem install rails` (ver paso abajo)
**PostgreSQL** 12+ Instalar PostgreSQL (https://www.postgresql.org/download)


### Instalación de Ruby (si no lo tienes)

Se recomienda usar un gestor de versiones de Ruby. Elige una opción:

**Opción A: rbenv (recomendado)**
```bash
# Instalar rbenv (Ubuntu/Debian)
sudo apt-get install -y rbenv ruby-build

# Instalar rbenv (macOS)
brew install rbenv ruby-build

# Instalar Ruby 3.4.0
rbenv install 3.4.0
rbenv global 3.4.0
```
Guía completa: https://github.com/rbenv/rbenv#installation

**Opción B: RVM**
```bash
# Instalar RVM
\curl -sSL https://get.rvm.io | bash -s stable

# Instalar Ruby 3.4.0
rvm install 3.4.0
rvm use 3.4.0 --default
```
Guía completa: https://rvm.io/rvm/install

### Instalación de Rails (si no lo tienes)

Una vez instalado Ruby, instalar Rails es un solo comando:
```bash
gem install rails -v 8.0.4
```

### Instalación de PostgreSQL (si no lo tienes)

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

**macOS (Homebrew):**
```bash
brew install postgresql@16
brew services start postgresql@16
```

---

## Instalación Paso a Paso

### 1. Clonar el repositorio

```bash
git clone https://github.com/RaulAlejandro/retail_catalog.git
cd retail_catalog
```

### 2. Instalar dependencias de Ruby

```bash
bundle install
```

Si encuentras problemas con la gema `pg`, asegúrate de tener PostgreSQL instalado:

**En Ubuntu/Debian:**
```bash
sudo apt-get install libpq-dev
```

**En macOS:**
```bash
brew install postgresql
```

### 3. Instalar dependencias de JavaScript

```bash
rails importmap:install
```

---

## Configuración de Base de Datos

edita el archivo `config/database.yml`:

```yaml
development:
  <<: *default
  database: retail_catalog_development
  host: localhost
  username: TU_USUARIO
  password: TU_PASSWORD
```

### Crear y configurar la base de datos

```bash
# Crear la base de datos
rails db:create

# Ejecutar las migraciones
rails db:migrate

# Cargar datos de prueba (24 productos de ejemplo)
rails db:seed
```

**Resultado esperado:**
- Base de datos `retail_catalog_development` creada
- 4 migraciones ejecutadas exitosamente
- 24 productos de prueba insertados en 5 categorías

---

## Ejecución del Proyecto

### Iniciar el servidor de desarrollo

```bash
rails server
```

o abreviado:

```bash
rails s
```

El servidor estará disponible en: **http://localhost:3000**

---

## Solución de Problemas

### Error: "PG::ConnectionBad"

**Causa**: PostgreSQL no está corriendo o las credenciales son incorrectas.

**Solución**:
```bash
# Verificar que PostgreSQL esté corriendo
sudo systemctl status postgresql

# Iniciar PostgreSQL si está detenido
sudo systemctl start postgresql

# Verificar credenciales en config/database.yml
```

### Error: "ActiveRecord::NoDatabaseError"

**Causa**: La base de datos no ha sido creada.

**Solución**:
```bash
rails db:create
rails db:migrate
rails db:seed
```

### Error: "Bundler::GemNotFound"

**Causa**: Falta instalar las gemas.

**Solución**:
```bash
bundle install
```

### Error: "LoadError: cannot load such file -- pg"

**Causa**: Falta la biblioteca de desarrollo de PostgreSQL.

**Solución en Ubuntu/Debian**:
```bash
sudo apt-get install libpq-dev
bundle install
```

### Error: "ImportMap::MissingAssetError"

**Causa**: Assets de JavaScript no configurados.

**Solución**:
```bash
rails importmap:install
```

### La paginación o búsqueda no funciona

**Causa**: JavaScript no está cargando correctamente.

**Solución**:
1. Verificar que importmap esté instalado
2. Revisar la consola del navegador en busca de errores
3. Reiniciar el servidor Rails

### Los productos no aparecen

**Causa**: No se ejecutó `db:seed`.

**Solución**:
```bash
rails db:seed
```

---

## Escalabilidad

### Para escalar con mayor volumen de productos (>100K):

#### 1. Base de Datos
- **Elasticsearch** para búsqueda avanzada
- **Read replicas** de PostgreSQL
- **Particionamiento** de tabla products por categoría o fecha
- **Connection pooling** con PgBouncer

#### 2. Caché
- **Redis** para caché de queries y sesiones
- **Fragment caching** en product cards
- **CDN** para imágenes estáticas (Cloudflare, CloudFront)

#### 3. Performance
- **Background jobs** con Sidekiq para operaciones pesadas
- **Eager loading** consistente (includes, preload)
- **Índices compuestos** adicionales según patrones de uso
- **Database query optimization** con EXPLAIN ANALYZE

#### 4. Infraestructura
- **Load balancer** (Nginx, HAProxy)
- **Horizontal scaling** de app servers
- **Assets precompilados** en CDN
- **Monitoring** con New Relic o Datadog

---

## Decisiones Técnicas

### Service Objects
Encapsulan lógica de negocio compleja (ej: `ProductFilterService`) para mantener los controladores delgados.

### Scopes en Modelos
Queries reutilizables y componibles para mantener el modelo como fuente única de verdad.

### Hotwire sobre JavaScript
Interactividad SPA sin complejidad de frameworks frontend, aprovechando el poder de Rails.

### PostgreSQL Full-Text Search
Búsqueda nativa sin dependencias externas, suficiente hasta ~500K registros.

### Turbo Frames
Actualizaciones parciales de página para mejor UX sin escribir JavaScript.

### Stimulus Controllers
JavaScript mínimo y enfocado, solo donde se necesita interactividad adicional.

---