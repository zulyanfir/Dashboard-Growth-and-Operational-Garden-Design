with usr as(
	select 
		id_user, 
		name as user_name,
		status
	from 
		user 
), prm as(
	select 
		id_promo,
		code,
		type,
		total_promo
	from 
		promo_code pc
), ctgr as(
	select
		id_category,
		size
	from 
		category_size
), dsg as(
	select
		id_design, 
		id_category,
		id_type,
		design_name,
		status as design_status
	from 
		design
), ord_dsg as (
	select 
		id_order,
		id_user,
		id_promo,
		id_category,
		id_designer,
		id_design_finish,
		size_area,
		rating,
		status as order_status,
		price,
		province,
		total_promo,
		created_at,
		updated_at
	from
		order_design
), ctgr_dsg as(
	select 
		id_category_design,
		name as category_name
	from 
		category_design
), det_ord_dsg as(
	select 
		id_order
	from 
		detail_order_design
), add_comp as(
	select 
		id,
		latitude,
		longitude,
		administrative_area_level_1,
		administrative_area_level_2,
		administrative_area_level_3
	from 
		address_components
)
select 
	ord_dsg.id_order,
	usr.id_user,
	prm.id_promo,
	ctgr.id_category,
	ord_dsg.id_design_finish,
	ctgr_dsg.id_category_design,
	ord_dsg.created_at,
	ord_dsg.updated_at,
	dsg.design_name,
	dsg.design_status,
	ctgr_dsg.category_name,
	ord_dsg.size_area,
	ord_dsg.rating,
	ord_dsg.order_status,
	ord_dsg.price,
	ord_dsg.total_promo,
	prm.code,
	prm.type,
	prm.total_promo,
	ctgr.size,
	ord_dsg.province,
	add_comp.latitude,
	add_comp.longitude,
	add_comp.administrative_area_level_1,
	add_comp.administrative_area_level_2,
	add_comp.administrative_area_level_3,
	usr.user_name,
	usr.status
from 
	ord_dsg
left join 
	usr on usr.id_user = ord_dsg.id_user
left join
	prm on prm.id_promo = ord_dsg.id_promo
left join
	ctgr on ctgr.id_category = ord_dsg.id_category
left join
	dsg on dsg.id_design = ord_dsg.id_design_finish
left join
	det_ord_dsg on det_ord_dsg.id_order = ord_dsg.id_order
left join
	ctgr_dsg on ctgr_dsg.id_category_design = dsg.id_type
left join 
	add_comp on add_comp.id = ord_dsg.province
limit 500;
