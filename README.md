# Catálogo de Productos Retail

Sistema de catálogo de productos e-commerce con búsqueda, filtros y ordenamiento.

## Requisitos
- Ruby 3.4.0
- PostgreSQL 12+
- Rails 8.0.4

## Instalación

1. Clonar repositorio

2. Instalar dependencias:
   ```bash
   bundle install
   ```

3. Configurar base de datos:
   - Actualizar `config/database.yml` con las credenciales de PostgreSQL
   - Crear y configurar base de datos:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Iniciar servidor:
   ```bash
   rails server
   ```

5. Visitar http://localhost:3000

## Funcionalidades

- ✅ Listado paginado de productos (grid de tarjetas)
- ✅ Búsqueda full-text por nombre/descripción
- ✅ Filtros por categoría, marca, precio, stock
- ✅ Ordenamiento (precio, fecha)
- ✅ Detalle de producto con productos relacionados
- ✅ UI responsive con Metronic template
- ✅ Interactividad dinámica con Hotwire (Turbo + Stimulus)

## Stack Técnico

- **Backend:** Ruby on Rails 8.0.4
- **Database:** PostgreSQL (búsqueda full-text nativa con tsvector)
- **Frontend:** Hotwire (Turbo + Stimulus)
- **UI Template:** Metronic (demo20)
- **Assets:** Propshaft + Importmap
- **Pagination:** Kaminari
- **Search:** pg_search

## Estructura del Proyecto

```
app/
├── models/
│   └── product.rb           # Modelo de producto con validaciones y scopes
├── controllers/
│   ├── products_controller.rb  # Catálogo y detalle de productos
│   └── home_controller.rb      # Página de inicio
├── services/
│   └── product_filter_service.rb  # Lógica de filtrado de productos
├── views/
│   ├── products/
│   │   ├── index.html.erb       # Grid de productos
│   │   ├── show.html.erb        # Detalle de producto
│   │   ├── _filters.html.erb    # Sidebar de filtros
│   │   ├── _toolbar.html.erb    # Búsqueda y ordenamiento
│   │   └── _product_card.html.erb  # Tarjeta de producto
│   ├── home/
│   │   └── index.html.erb       # Página de inicio
│   └── shared/
│       ├── _header.html.erb     # Header de navegación
│       └── _footer.html.erb     # Footer
└── javascript/
    └── controllers/
        ├── filters_controller.js   # Stimulus controller para filtros
        └── search_controller.js    # Stimulus controller para búsqueda

db/
├── migrate/
│   ├── XXX_create_products.rb        # Tabla de productos
│   └── XXX_add_search_to_products.rb # Búsqueda full-text
└── seeds.rb                          # Datos de prueba
```

## Características de la Base de Datos

### Tabla Products

- `product_id`: ID externo único (e.g., "p-001")
- `name`: Nombre del producto
- `description`: Descripción detallada
- `category`: Categoría del producto
- `brand`: Marca
- `price`: Precio actual
- `old_price`: Precio anterior (para mostrar descuentos)
- `stock`: Cantidad disponible
- `tags`: Array de etiquetas (JSON)
- `image_url`: URL de la imagen
- `active`: Estado activo/inactivo
- `search_vector`: Vector de búsqueda full-text (tsvector)

### Índices

- Índice único en `product_id`
- Índices en `name`, `category`, `brand`, `price`
- Índice compuesto en `[active, created_at]`
- Índice GIN en `search_vector` para búsqueda full-text

### Búsqueda Full-Text

PostgreSQL trigger que actualiza automáticamente el `search_vector` cuando se crea o actualiza un producto, permitiendo búsquedas rápidas y relevantes.

## Testing

```bash
rails test
```

## Datos de Prueba

El archivo `db/seeds.rb` incluye 10 productos de ejemplo en diferentes categorías:
- Calzado
- Ropa
- Electrónica
- Hogar
- Accesorios

Para recargar los datos:
```bash
rails db:seed
```

## Escalabilidad

Para escalar con mayor volumen de productos:

1. **Base de Datos:**
   - Migrar a Elasticsearch para búsqueda (>1M productos)
   - Implementar read replicas
   - Particionar tabla products por categoría

2. **Caché:**
   - Fragment caching en product cards
   - Redis para caché de queries
   - CDN para imágenes

3. **Performance:**
   - Background jobs para actualizaciones
   - Eager loading consistente
   - Índices compuestos adicionales

4. **Infraestructura:**
   - Horizontal scaling con load balancer
   - Assets en CDN
   - Database connection pooling

## Desarrollo

Este proyecto fue implementado siguiendo las mejores prácticas de Rails 8:
- Service Objects para lógica de negocio compleja
- Scopes en modelos para queries reutilizables
- Hotwire para interactividad sin JavaScript custom
- Stimulus controllers mínimos y enfocados
- Propshaft para assets modernos
- PostgreSQL nativo para búsqueda full-text
