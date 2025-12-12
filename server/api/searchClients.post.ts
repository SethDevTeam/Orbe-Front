// server/api/searchClients.post.ts
import Database from 'better-sqlite3'
import { join } from 'path'

export default defineEventHandler(async (event) => {
        const body = await readBody(event)
        const query = body.query || ''

        console.log('searchClients API called with query:', query)

        // Use the correct path to your database
        const dbPath = join(process.cwd(), 'server', 'db', 'clients.sqlite')
        console.log('Database path:', dbPath)

        const db = new Database(dbPath)

        try {
                let results

                if (!query || query.trim() === '') {
                        // Return all clients ordered by name
                        const stmt = db.prepare(`
        SELECT id, first_name, last_name, email, phone1 
        FROM customers 
        ORDER BY first_name, last_name
      `)
                        results = stmt.all()
                        console.log('All clients query returned:', results?.length, 'rows')
                } else {
                        // Search clients by first or last name
                        const stmt = db.prepare(`
        SELECT id, first_name, last_name, email, phone1 
        FROM customers 
        WHERE first_name LIKE ? OR last_name LIKE ? 
        ORDER BY first_name, last_name
      `)
                        results = stmt.all(`%${query}%`, `%${query}%`)
                        console.log('Search query returned:', results?.length, 'rows')
                }

                // Log first result for debugging
                if (results && results.length > 0) {
                        console.log('First result sample:', results[0])
                }

                return results || []

        } catch (error) {
                console.error('Database error:', error)
                throw createError({
                        statusCode: 500,
                        message: 'Error querying database'
                })
        } finally {
                db.close()
        }
})
