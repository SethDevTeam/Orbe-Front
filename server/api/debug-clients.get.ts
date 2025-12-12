import Database from 'better-sqlite3'
import { join } from 'path'

export default defineEventHandler(async (event) => {
        const dbPath = join(process.cwd(), 'server/db/clients.sqlite')

        try {
                const db = new Database(dbPath, { readonly: true })

                // Check tables
                const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all()

                // Get sample data
                const sampleData = db.prepare('SELECT * FROM customers LIMIT 3').all()

                db.close()

                return {
                        database: 'clients',
                        dbPath,
                        tables,
                        sampleData,
                        message: 'Connected successfully'
                }
        } catch (error) {
                return {
                        error: String(error),
                        dbPath,
                        message: 'Failed to connect'
                }
        }
})
