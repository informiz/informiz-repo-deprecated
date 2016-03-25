LOAD CSV WITH HEADERS FROM "file:///resources/informiz.csv" AS row CREATE (n:Informi) SET n = row, n.id = toInt(row.id)
LOAD CSV WITH HEADERS FROM "file:///resources/informi_categories.csv" AS row CREATE (n:Category) SET n = row, n.id = toInt(row.id)
LOAD CSV WITH HEADERS FROM "file:///resources/tags.csv" AS row CREATE (n:Tag) SET n = row, n.id = toInt(row.id)
LOAD CSV WITH HEADERS FROM "file:///resources/langs.csv" AS row CREATE (n:Language) SET n = row, n.id = toInt(row.id)
CREATE INDEX ON :Informi(id)
CREATE INDEX ON :Category(id)
CREATE INDEX ON :Tag(id)
CREATE INDEX ON :Language(id)
LOAD CSV FROM "file:///resources/taxonomies.csv" AS row MATCH (i:Informi {id: toInt(row[0])}) MATCH (c:Category {id: toInt(row[1])}) CREATE (i)-[:BELONGS_TO]->(c)
LOAD CSV FROM "file:///resources/taxonomies.csv" AS row MATCH (i:Informi {id: toInt(row[0])}) MATCH (t:Tag {id: toInt(row[1])}) CREATE (i)-[:TAGGED]->(t)
LOAD CSV FROM "file:///resources/taxonomies.csv" AS row MATCH (i:Informi {id: toInt(row[0])}) MATCH (l:Language {id: toInt(row[1])}) CREATE (i)-[:INLANG]->(l)
LOAD CSV FROM "file:///resources/links.csv" AS row MATCH (src:Informi {id: toInt(row[0])}) MATCH (target:Informi {id: toInt(row[2])}) CREATE (src)-[:RELATED_TO {description:row[1]}]->(target)