-- Create view of sales data and dimensions for retail store channel and time from week 202100 to 202330
CREATE VIEW retail_202200_202330 AS
SELECT	a.qty, a.cogsusd, a.revenueusd, 	
		b.*,
		c.storecode, c.channel, c.citylevel, c.areagroup, c.urbanization, c.branch, c.active, c.storelevel, c.showroomarea, c.warehousearea,
		d.*
FROM sales a
INNER JOIN product b
ON a.sku = b.sku
INNER JOIN distributionchannel c
ON a.customercode = c.customercode
INNER JOIN calendar d
ON a.yearweek = d.yearweek
WHERE c.channel = 'Retail Store' AND CAST(d.yearweek AS NUMERIC) BETWEEN 202200 AND 202330
ORDER BY d.yearweek ASC;
