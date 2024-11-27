/* Master Query
(Tabel design dan desc_design)
*/
with dsg as(
	select
		id_design, 
		id_category,
		id_type,
		design_name,
		status as design_status
	from 
		design
), desc_dsg as (
	select 
		id_desc,
		id_design,
		id_item,
		item_name,
		volume,
		category,
		denom,
		item_unit_qty,
		item_unit_cost,
		item_unit_price,
		item_denom_cost,
		item_denom_price,
		item_total_cost,
		item_total_price
	from 
		desc_design
)
select 
	dsg.id_design, 
	dsg.id_category,
	dsg.id_type,
	desc_dsg.id_desc,
	desc_dsg.id_item,
	dsg.design_name,
	dsg.design_status,
	desc_dsg.item_name,
	desc_dsg.volume,
	desc_dsg.category,
	desc_dsg.denom,
	desc_dsg.item_unit_qty,
	desc_dsg.item_unit_cost,
	desc_dsg.item_unit_price,
	desc_dsg.item_denom_cost,
	desc_dsg.item_denom_price,
	desc_dsg.item_total_cost,
	desc_dsg.item_total_price
from 
	dsg 
left join 
	desc_dsg on desc_dsg.id_design = dsg.id_design 
limit 10;