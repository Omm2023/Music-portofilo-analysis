#Who is the senior most employee?
create database project;
select * from new_schema.employee
order by levels desc limit 1


#which country have the most invoices?
use project;
select count(billing_country) as c,billing_country from new_schema.invoice
group by billing_country
order by c desc


#What are the top 3 values of total invoices ?
use project;
select * from new_schema.invoice
order by total desc
limit 3

#Which city has best costumers on the basis of invoice_total from different cities.
use project;
select sum(total) as invoice_total, billing_city from new_schema.invoice
group by billing_city
order by invoice_total desc

#who is the best costumer? who has spent the most money?
use project;
select customer.customer_id,customer.first_name,customer.last_name , SUM(total.invoice) as total
from new_schema.customer
join new_schema.invoice
on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1


#who is the best costumer? who has spent the most money?
use project;
select customer.customer_id,customer.first_name,customer.last_name , SUM(total.invoice) as total
from new_schema.customer
join new_schema.invoice
on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1


#write a qeury that returns the Artist name and total track count of top 10 Rock bands
use new_schema;
select artist.artist_id,artist.name, count(artist.artist_id) as number_of_songs
from track
join album2 on album2.album_id=track.album_id
join artist on artist.artist_id=album2.artist_id  
join genre on genre.genre_id=track.genre_id
where genre.name='Rock'
group by artist_id
order by count(artist.artist_id) desc
limit 10;


#select the songs where the time in milliseconds in  larger than the average time
use new_schema;
select name,milliseconds from track
where milliseconds>(
select avg(milliseconds) as avg_title_track_length
from track)
order by milliseconds desc;


#Find the amont spend by the each consumer on the artist?Write a query to return customer name, artist name and total spent.
use new_schema;
WITH best_selling_artist AS (
    SELECT 
        artist.artist_id AS artist_id,
        artist.artist_name AS artist_name,
        SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
    FROM 
        invoice_line
    JOIN 
        track ON track.track_id = invoice_line.track_id
    JOIN 
        album ON album2.album2_id = track.album2_id
    JOIN 
        artist ON artist.artist_id = album2.artist_id
    GROUP BY 
        artist.artist_id, artist.artist_name
    ORDER BY 
        total_sales DESC
    LIMIT 1
)

select c.customer_id, c.first_name, c.last_name, bsa.artist_name,
sum(il.unit_price*il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track t on t.track_id=il.track_id
join album2 alb on alb.album_id=t.album_id
join best_selling_artist bsa on bsa.artist_id=alb.artist_id
group by 1,2,3,4
order by 5 desc;




 











