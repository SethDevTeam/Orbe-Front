async function dynamicSearch(name: string) {
  // Import inventory database and show it in the console log
  const db = useDatabase("prototypeDB");

  const invoices = await db.sql`
    SELECT * FROM invoices
    WHERE name LIKE '%${name}%'
  `;

  console.log(invoices);
}

export { dynamicSearch }
