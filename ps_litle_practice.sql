DELIMITER //
create procedure ObtenerPelisPorCategoria(IN CATEGORIA VARCHAR(20))
BEGIN
	SELECT 
		filcat.category_id,
		fil.title,
        fil.description,
        fil.release_year,
        CASE
			when fil.language_id = 1 then "English"
            when fil.language_id = 2 then "Italian"
            when fil.language_id = 3 then "Japanese"
            when fil.language_id = 4 then "Mandarin"
            when fil.language_id = 5 then "French"
            when fil.language_id = 6 then "German"
        END AS `LENGUAJE`
    FROM film_category filcat
    INNER JOIN film fil
    ON fil.film_id = filcat.film_id
    INNER JOIN language len
    ON len.language_id = fil.language_id
	WHERE filcat.category_id = CATEGORIA;
END
// DELIMITER 

DELIMITER //
CREATE PROCEDURE ActualizarDuracionRenta(IN id_peli INT, IN nueva_duracion INT)
begin
	UPDATE film 
	SET rental_duration = nueva_duracion
    WHERE film_id = id_peli;
end 
// DELIMITER ;


DELIMITER //
CREATE PROCEDURE ContarPelisPorActor(IN id_actor INT)
begin
	SELECT COUNT(*) AS cantitidad, filac.actor_id, ac.first_name, ac.last_name
    FROM film_actor filac
	INNER JOIN actor ac
    ON ac.actor_id = filac.actor_id
    WHERE filac.actor_id = id_actor
    GROUP BY filac.actor_id;
end
// DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarAlquiler(IN id_rental INT)
begin
	DELETE  FROM rental 
    where rental_id = id_rental;
    
	DELETE FROM payment 
    WHERE rental_id = id_rental;
end
// DELIMITER ;


DELIMITER //

CREATE PROCEDURE TopSpendingCustomers()
begin
	select 
    cus.customer_id,
    cus.first_name,
    cus.last_name,
    sum(pay.amount) as sum
    from customer cus
    inner join payment pay
    on cus.customer_id = pay.customer_id
	GROUP BY pay.customer_id
    HAVING sum>100
    ORDER BY sum DESC
    limit 5;
END
// DELIMITER  ;

-- select * from customer;
-- select * from payment;alter

-- -----------------------------------------

DELIMITER //
create procedure FrequentActors()
begin
		select 
        filact.actor_id,
        count(filact.actor_id) as cantidad,
        ac.first_name,
        ac.last_name
		from film_actor filact
        INNER JOIN actor ac
        on ac.actor_id = filact.actor_id
        group by filact.actor_id
        HAVING cantidad>10
        ORDER BY cantidad
        limit 10;
end
// DELIMITER ;

-- select * from actor;
-- select * from film_actor;


DELIMITER //
CREATE PROCEDURE MovieRentalCategory():
BEGIN 
	select 
	count(fil.film_id) as cantidad_rentada,
    inv.film_id as id_film,
    CASE 
		WHEN count(fil.film_id)>10 THEN "EXCELENTE"
        WHEN count(fil.film_id)<10 and count(fil.film_id)>5 THEN "POPULAR"
        WHEN count(fil.film_id)<5 THEN "POCOVISTA"
	end as "condicion",
    fil.title
    from rental rent
    INNER JOIN inventory inv
    on rent.inventory_id = inv.inventory_id
    INNER JOIN film fil
    on fil.film_id = inv.film_id
    group by fil.film_id;
END
// DELIMITER ;

-- select * from film;
-- select * from rental;
-- select * from inventory;

DELIMITER // 
create procedure StoreRevenueCategory()
BEGIN 
# Categoría de ingresos de la tienda 
	select 
		sum(pay.amount) as cantidad_ingresos,
        stor.store_id as id_tienda
	from payment as pay
    inner join staff stf
    on stf.staff_id = pay.staff_id 
    inner join store stor 
    on stor.store_id = stf.store_id
    group by stor.store_id;
END
// DELIMITER ;

-- select * from store;
-- select * from staff;
-- select * from payment;
DELIMITER //
CREATE PROCEDURE CustomerSpendingLevel()
BEGIN 
	select 
		cus.first_name,
        cus.last_name,
        sum(amount) as cantidad_gastada,
        CASE 
			WHEN sum(amount)>500 THEN "VIP"
            WHEN sum(amount) between 500 and 200  THEN "Frecuente"
            when sum(amount) BETWEEN 0 AND 200 then "Ocasional"
		end as "Estado"
    from customer cus
    inner join payment pay
    on pay.customer_id = cus.customer_id
    group by cus.customer_id;
END
// DELIMITER ;


-- select * from customer;
-- select * from payment;


DELIMITER //
CREATE PROCEDURE TopProfitableCategories()
BEGIN 
	select 
	cat.category_id,
    cat.name as "categoria",
    sum(pay.amount) as cantidad_recaudada
    from  payment pay
    inner join rental rent
    on pay.rental_id = rent.rental_id
    inner join inventory inv
    on inv.inventory_id = rent.inventory_id
    inner join film_category filca
    on filca.film_id = inv.film_id
    inner join category cat
    on cat.category_id = filca.category_id
    GROUP BY cat.category_id
    HAVING cantidad_recaudada >1000
    ORDER BY 3;
END
// DELIMITER ;

-- select * from film_category;
-- select * from category;
-- select * from inventory;
-- SELECT * FROM rental;
-- select * from payment;


