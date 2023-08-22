
--        NGUYỄN HỮU CƯỜNG     21099791
--              ----- LAB 6 -----
--1. Hiển thị thông tin về hóa đơn có mã ‘10248’, bao gồm: OrderID, 
--OrderDate, CustomerID, EmployeeID, ProductID, Quantity, Unitprice, 
--Discount.

select od.OrderID, OrderDate, CustomerID, EmployeeID, ProductID, Quantity, Unitprice, Discount
from [dbo].[Orders] od join [dbo].[Order Details] odd on od.OrderID = odd.OrderID
where od.OrderID = 10248

--2. Liệt kê các khách hàng có lập hóa đơn trong tháng 7/1997 và 9/1997. 
--Thông tin gồm CustomerID, CompanyName, Address, OrderID, 
--Orderdate. Được sắp xếp theo CustomerID, cùng CustomerID thì sắp xếp 
--theo OrderDate giảm dần.


select cus.CustomerID, CompanyName, Address, OrderID, Orderdate 
from [dbo].[Customers] cus join [dbo].[Orders] od on cus.CustomerID = od.CustomerID
where month(od.OrderDate) = 7 or month(od.OrderDate) = 9 and year(od.OrderDate) = 1997
order by cus.CustomerID , od.OrderDate desc

--3. Liệt kê danh sách các mặt hàng xuất bán vào ngày 19/7/1996. Thông tin 
--gồm : ProductID, ProductName, OrderID, OrderDate, Quantity.

select p.ProductID, p.ProductName, odd.OrderID, OrderDate, Quantity 
from [dbo].[Products] p join [dbo].[Order Details] odd on p.ProductID = odd.ProductID join [dbo].[Orders] o on o.OrderID = odd.OrderID
where o.OrderDate = '19960719'

--4. Liệt kê danh sách các mặt hàng từ nhà cung cấp (supplier) có mã 1,3,6 và
--đã xuất bán trong quý 2 năm 1997. Thông tin gồm : ProductID, 
--ProductName, SupplierID, OrderID, Quantity. Được sắp xếp theo mã 
--nhà cung cấp (SupplierID), cùng mã nhà cung cấp thì sắp xếp theo 
--ProductID

select p.ProductID, ProductName, SupplierID, o.OrderID, Quantity
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = od.OrderID join [dbo].[Products] p on od.ProductID = p.ProductID
where datepart(qq, o.OrderDate) = 2 and year(o.OrderDate) = 1997
and  (p.SupplierID = 1 or p.SupplierID = 3 or p.SupplierID = 6)

--5. Liệt kê danh sách các mặt hàng có đơn giá bán bằng đơn giá mua

select * from [dbo].[Products] p join [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.UnitPrice = od.UnitPrice

--6. Danh sách các mặt hàng bán trong ngày thứ 7 và chủ nhật của tháng 12 
--năm 1996, thông tin gồm ProductID, ProductName, OrderID, OrderDate, 
--CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp 
--xếp theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.

select p.ProductID, ProductName, o.OrderID, OrderDate,CustomerID, od.Unitprice, Quantity, Quantity*od.UnitPrice as ToTal
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = od.OrderID join [dbo].[Products] p on p.ProductID = od.ProductID
where datepart(w, o.OrderDate) = 7 or datepart(w, o.OrderDate) = 1

--7. Liệt kê danh sách các nhân viên đã lập hóa đơn trong tháng 7 của năm 
--1996. Thông tin gồm : EmployeeID, EmployeeName, OrderID, 
--Orderdate.
select e.EmployeeID, LastName + ' ' + FirstName as EmployeeName, OrderID, Orderdate
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID
where month(o.OrderDate) = 7 and year(o.OrderDate) = 1996
--8. Liệt kê danh sách các hóa đơn do nhân viên có Lastname là ‘Fuller’ lập.
--Thông tin gồm : OrderID, Orderdate, ProductID, Quantity, Unitprice.
select o.OrderID, Orderdate, ProductID, Quantity, Unitprice
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = od.OrderID join [dbo].[Employees] e on e.EmployeeID = o.EmployeeID
where e.LastName = 'Fuller'

--9. Liệt kê chi tiết bán hàng của mỗi nhân viên theo từng hóa đơn trong năm 
--1996. Thông tin gồm: EmployeeID, EmployName, OrderID, Orderdate, 
--ProductID, quantity, unitprice, ToTalLine=quantity*unitprice. 

select e.EmployeeID, e.FirstName + ' '+ e.LastName, o.OrderID, Orderdate, ProductID, quantity, unitprice, quantity*od.unitprice as  ToTalLine
from [dbo].[Employees] e join [dbo].[Orders] o on  e.EmployeeID = o.EmployeeID join [dbo].[Order Details] od on o.OrderID = od.OrderID
where year(o.OrderDate) = 1996

--10.Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 
--1996. 
select * from [dbo].[Orders] o 
where datepart(w, o.OrderDate) = 7 and MONTH(o.OrderDate) =12 and year(o.OrderDate) = 1996

--11.Liệt kê danh sách các nhân viên chưa lập hóa đơn (dùng LEFT 
--JOIN/RIGHT JOIN).

select * from [dbo].[Employees] e left join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID
where o.EmployeeID is null

--12.Liệt kê danh sách các sản phẩm chưa bán được (dùng LEFT 
--JOIN/RIGHT JOIN).

select p.ProductID from [dbo].[Products] p left join [dbo].[Order Details] o on p.ProductID = o.ProductID
where o.OrderID is null

--13.Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN).

select * from [dbo].[Customers] c left join [dbo].[Orders] o on c.CustomerID = o.CustomerID
where o.CustomerID is null

--           ----  LAB 7 ----

--1. Liệt kê danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông 
--tin bao gồm OrderID, OrderDate, Total. Trong đó Total là Sum của 
--Quantity * Unitprice, kết nhóm theo OrderID

select  o.OrderID, o.OrderDate, Sum(Quantity * od.Unitprice) as total 
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = od.OrderID
group by o.OrderID , o.OrderDate 

--2. Liệt kê danh sách các orders mà địa chỉ nhận hàng ở thành phố ‘Madrid’
--(Shipcity). Thông tin bao gồm OrderID, OrderDate, Total. Trong đó 
--Total là tổng trị giá hóa đơn, kết nhóm theo OrderID.

select o.OrderID, OrderDate, sum(od.UnitPrice) 
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = o.OrderID
group by o.OrderID , o.OrderDate  


--3. Sử dụng 2 table [Orders] và [Order Details], hãy viết các truy vấn thống 
--kê tổng trị giá các hóa đơn được xuất bán theo :
--- Tháng …
--- Năm …
--- CustomerID …
--- EmployeeID …
--- ProductID …

select o.OrderDate , sum(od.Quantity * od.UnitPrice) as total
from [dbo].[Orders] o join [dbo].[Order Details] od on o.OrderID = od.OrderID
group by o.OrderDate

--4. Cho biết mỗi Employee đã lập bao nhiêu hóa đơn. Thông tin gồm 
--EmployeeID, EmployeeName, CountOfOrder. Trong đó CountOfOrder 
--là tổng số hóa đơn của từng employee. EmployeeName được ghép từ 
--LastName và FirstName.

select e.EmployeeID, FirstName + ' ' + LastName as employeeName, count(o.OrderID)
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID
group by e.EmployeeID , FirstName , LastName

--5. Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng 
--tiền các hóa đơn tương ứng. Thông tin gồm EmployeeID, 
--EmployeeName, CountOfOrder , Total.

select e.EmployeeID ,FirstName + ' ' + LastName as EmployeeName, count(distinct o.OrderID) as CountOfOrder  , sum(od.Quantity * od.UnitPrice) as total
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID join [dbo].[Order Details] od on o.OrderID = od.OrderID
group by e.EmployeeID , FirstName , LastName

--6. Liệt kê bảng lương của mỗi Employee theo từng tháng trong năm 1996 
--gồm EmployeeID, EmployName, Month_Salary, Salary = 
--sum(quantity*unitprice)*10%. Được sắp xếp theo Month_Salary, cùmg 
--Month_Salary thì sắp xếp theo Salary giảm dần.

select e.EmployeeID, FirstName + ' ' + LastName as EmployeeName, month(o.OrderDate) as Month_Salary ,sum(quantity*unitprice)*10*0.1 as salary
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID join [dbo].[Order Details] od on o.OrderID = od.OrderID
where year(o.OrderDate) = 1996
group by e.EmployeeID , FirstName , LastName, month(o.OrderDate)
order by Month_Salary, salary desc

--7. Tính tổng số hóa đơn và tổng tiền các hóa đơn của mỗi nhân viên đã bán 
--trong tháng 3/1997, có tổng tiền >4000. Thông tin gồm EmployeeID, 
--LastName, FirstName, CountofOrder, Total.

select e.EmployeeID, e.LastName, e.FirstName, count(distinct o.OrderID) as CountofOrder, sum(od.Quantity * od.UnitPrice) as total
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID join [dbo].[Order Details] od on o.OrderID = od.OrderID
where month(o.OrderDate) = 3 and year(o.OrderDate) = 1997 
group by e.EmployeeID, e.LastName, e.FirstName
having sum(od.Quantity * od.UnitPrice) > 4000


--8. Liệt kê danh sách các customer ứng với tổng số hoá đơn, tổng tiền các 
--hoá đơn, mà các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng 
--tiền các hóa đơn >20000. Thông tin được sắp xếp theo CustomerID, 
--cùng mã thì sắp xếp theo tổng tiền giảm dần.

select c.CustomerID, count(distinct o.OrderID) as total_order, sum(od.Quantity * od.UnitPrice) sum_order
from [dbo].[Customers] c join [dbo].[Orders] o on c.CustomerID = o.CustomerID join [dbo].[Order Details] od on o.OrderID = od.OrderID
where o.OrderDate >='19961231' and o.OrderDate <= '19980101'
group by c.CustomerID

--9. Liệt kê danh sách các customer ứng với tổng tiền của các hóa đơn ở từng 
--tháng. Thông tin bao gồm CustomerID, CompanyName, Month_Year, 
--Total. Trong đó Month_year là tháng và năm lập hóa đơn, Total là tổng 
--của Unitprice* Quantity.



--10.Liệt kê danh sách các nhóm hàng (category) có tổng số lượng tồn 
--(UnitsInStock) lớn hơn 300, đơn giá trung bình nhỏ hơn 25. Thông tin 
--bao gồm CategoryID, CategoryName, Total_UnitsInStock, 
--Average_Unitprice.

select cat.CategoryID, CategoryName , sum(p.UnitsInStock) as Total_UnitsInStock, avg(p.UnitPrice) as Average_Unitprice
from [dbo].[Categories] cat join [dbo].[Products] p on cat.CategoryID = p.CategoryID
group by cat.CategoryID, CategoryName
having sum(p.UnitsInStock) >300 and avg(p.UnitPrice) <25

--11.Liệt kê danh sách các nhóm hàng (category) có tổng số mặt hàng
--(product) nhỏ hớn 10. Thông tin kết quả bao gồm CategoryID, 
--CategoryName, CountOfProducts. Được sắp xếp theo CategoryName, 
--cùng CategoryName thì sắp theo CountOfProducts giảm dần.

select cat.CategoryID, CategoryName, count(p.ProductID) CountOfProducts     -- chưa chắc 
from [dbo].[Categories] cat join [dbo].[Products] p on  cat.CategoryID = p.CategoryID
group by cat.CategoryID, CategoryName
having count(p.ProductID) < 10 
order by CategoryName,  CountOfProducts desc

--12.Liệt kê danh sách các Product bán trong quý 1 năm 1998 có tổng số 
--lượng bán ra >200, thông tin gồm [ProductID], [ProductName], 
--SumofQuatity 

select p.ProductID, ProductName, sum(od.Quantity) as SumofQuatity
from [dbo].[Products] p join [dbo].[Order Details] od on p.ProductID = od.ProductID join [dbo].[Orders] o on o.OrderID = od.OrderID
where datepart(qq, o.OrderDate) = 1 and year(o.OrderDate) = 1998
group by p.ProductID, ProductName
having sum(od.Quantity) > 200

--13.Cho biết Employee nào bán được nhiều tiền nhất trong tháng 7 năm 1997

select top 1 e.EmployeeID, sum(od.Quantity*od.UnitPrice) as total
from [dbo].[Employees] e join [dbo].[Orders] o on e.EmployeeID = o.EmployeeID join [dbo].[Order Details] od on o.OrderID = od.OrderID
where month(o.OrderDate) = 7 and year(o.OrderDate) = 1997
group by e.EmployeeID
order by total desc

--14.Liệt kê danh sách 3 Customer có nhiều đơn hàng nhất của năm 1996.

select top 3 cus.CustomerID, count(o.OrderID) as total
from [dbo].[Customers] cus join [dbo].[Orders] o on cus.CustomerID = o.CustomerID
where year(o.OrderDate) = 1996 
group by cus.CustomerID
order by total desc

--15.Liệt kê danh sách các Products có tổng số lượng lập hóa đơn lớn nhất.
--Thông tin gồm ProductID, ProductName, CountOfOrders

select p.ProductID, ProductName, count(od.OrderID) as CountOfOrders 
from [dbo].[Products] p join [dbo].[Order Details] od on p.ProductID = od.ProductID 
group by p.ProductID, ProductName
order by CountOfOrders desc

--               ---- LAB 8 -----

--1. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của 
--các product. Thông tin gồm ProductID, ProductName, Unitprice .

select  p.ProductID, p.ProductName, od.UnitPrice
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where od.UnitPrice > (select avg(od.UnitPrice) as gttb from [dbo].[Order Details] od)

--2. Liệt kê các product có đơn giá bán lớn hơn đơn giá bán trung bình của 
--các product có ProductName bắt đầu là ‘N’

select  p.ProductID, p.ProductName, od.UnitPrice
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where od.UnitPrice > 
(select avg(od.UnitPrice) as gttb from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.ProductName like 'N%'
)

--3. Danh sách các products có đơn giá mua lớn hơn đơn giá bán nhỏ nhất 
--của tất cả các products

select  p.ProductID, p.ProductName, od.UnitPrice
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where od.UnitPrice >
(select min(p.UnitPrice) as gttb from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID)

--4. Cho biết những product có đơn vị tính có chữ ‘box’ và có số lượng bán 
--lớn hơn số lượng trung bình bán ra.

select  p.ProductID, p.ProductName, od.UnitPrice, p.QuantityPerUnit
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.QuantityPerUnit like '%box%' and od.UnitPrice >
(select min(p.UnitPrice) as gttb from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID)

--5. Cho biết những sản phẩm có tên bắt đầu bằng chữ N và đơn giá bán > 
--đơn giá bán của (tất cả) những sản phẩm khác 

select  p.ProductID, p.ProductName, od.UnitPrice, p.QuantityPerUnit
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.QuantityPerUnit like 'N%' and od.UnitPrice >
(select max(p.UnitPrice) as gttb from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.ProductName like 'C%')
							--câu 5 lỗi đề cô ơi 

--6. Cho biết những sản phẩm thuộc nhóm hàng có mã 4 (categoryID) và có 
--tổng số lượng bán lớn hơn (tất cả) tổng số lượng của những sản phẩm 
--không thuộc nhóm hàng mã 4
--Lưu ý : Có nhiều phương án thực hiện các truy vấn sau. Hãy đưa ra 
--phương án sử dụng subquery.



select p.ProductID, p.ProductName, sum(od.Quantity) as total
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.CategoryID = 4 
group by p.ProductID,p.ProductName
having sum(od.Quantity) > all(select sum(od.Quantity) as quatity 
from [dbo].[Products] p join  [dbo].[Order Details] od on p.ProductID = od.ProductID
where p.CategoryID <> 4 
group by p.ProductID
)

--7. Danh sách các products đã có khách hàng mua hàng (tức là ProductID có 
--trong [Order Details]). Thông tin bao gồm ProductID, ProductName, 
--Unitprice



--8. Danh sách các hóa đơn của những khách hàng ở thành phố LonDon và 
--Madrid.
--9. Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông 
--tin gồm ProductID, ProductName.
--10.Liệt kê danh sách các sản phẩm chưa bán được trong tháng 6 năm 1996
--11.Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay
--12.Liệt kê danh sách các Customers chưa mua hàng trong năm 1997
--13.Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T 
--trong tháng 7 năm 1997
--14.Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này 
--chỉ mua những sản phẩm có mã >=3
--15.Tìm các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT 
--EXISTS, dùng LEFT JOIN, dùng NOT IN )
--16.Cho biết sản phẩm nào có đơn giá bán cao nhất trong số những sản phẩm
--có đơn vị tính có chứa chữ ‘box’ .
--17. Danh sách các Products có tổng số lượng (Quantity) bán được lớn nhất.