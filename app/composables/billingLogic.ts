async function dynamicSearch(name: string) {
  // Import inventory database and show it in the console log
  const db = useDatabase("prototypeDB");

  const bills = await db.sql`
    SELECT * FROM bills
    WHERE name LIKE '%${name}%'
  `;

  console.log(bills);
}

export { dynamicSearch }
