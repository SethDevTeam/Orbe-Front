import { defineEventHandler, readBody } from 'h3'
import Database from 'better-sqlite3'

// Create connection - this will use your actual database
const db = new Database('./server/db/prototype.sqlite', {
        readonly: false,
        fileMustExist: true  // This will error if the file doesn't exist
})

export default defineEventHandler(async (event) => {
        try {
                const { name } = await readBody(event)
                console.log('Searching for:', name)

                // Search products with parameterized query
                // This should be executed by the backend in another file
                const searchTerm = `%${name || ''}%`
                const stmt = db.prepare(`
      SELECT 
        id,
        name,
        sku,
        description,
        price,
        quantity as stock,
        image_url
      FROM products 
      WHERE name LIKE ?
      ORDER BY name
    `)

                const products = stmt.all(searchTerm)

                console.log('Found products:', products?.length || 0)
                return products || []

        } catch (error) {
                console.error('Search error:', error)
                throw createError({
                        statusCode: 500,
                        statusMessage: 'Failed to search products',
                        data: String(error)
                })
        }
})
