
# STANDARDIZING DATE FORMAT


Select *
From [Portfolio Project].dbo.[NashvilleHousing]

Select SaleDateconverted, CONVERT(date, saledate)
From [Portfolio Project].dbo.[NashvilleHousing]

Update [NashvilleHousing]
Set SaleDate = convert(date, saledate)

Alter Table Nashvillehousing	
Add SaleDateConverted Date

Update [Nashville Housing]
Set SaleDateconverted = convert(date, saledate)







# POPULATE PROPERTY ADDRESS DATE


Select *
From [Portfolio Project].dbo.[Nashville Housing]
where propertyaddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.propertyaddress)
From [Portfolio Project].dbo.[Nashville Housing] a
join [Portfolio Project].dbo.[Nashville Housing] b
on a.parcelID = b.parcelID
and a.uniqueID <> b.uniqueID
where a.propertyaddress is null

update a
set PropertyAddress = isnull(a.propertyaddress,b.propertyaddress)
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.propertyaddress)
From [Portfolio Project].dbo.[Nashville Housing] a
join [Portfolio Project].dbo.[Nashville Housing] b
on a.parcelID = b.parcelID
and a.uniqueID <> b.uniqueID
where a.propertyaddress is null







# BREAK OUT ADDRESS INTO INDIVIDUAL COLUMNS


Select PropertyAddress
From [Portfolio Project].dbo.[Nashville Housing]
--where propertyaddress is null
--order by ParcelID

Select
SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) as address,
SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) +1, len(propertyaddress)) as address
from [Portfolio Project].dbo.[Nashville Housing] 


Alter Table NashvilleHousing	
Add propertysplitaddress nvarchar(255);

Update [NashvilleHousing]
Set propertysplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1) 

Alter Table [NashvilleHousing]
Add propertysplitcity nvarchar(255)

Update [NashvilleHousing]
Set propertysplitcity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) +1, len(propertyaddress))

Select *
From [Portfolio Project].dbo.[NashvilleHousing]


Select owneraddress
From [Portfolio Project].dbo.[NashvilleHousing]

Select PARSENAME(replace(owneraddress, ',', '.'), 3),
PARSENAME(replace(owneraddress, ',', '.'), 2),
PARSENAME(replace(owneraddress, ',', '.'), 1)
From [Portfolio Project].dbo.[NashvilleHousing]









# CHANGE Y & N TO YES AND NO IN SOLD AS VACANT FIELD


Select Distinct(soldasvacant), count(soldasvacant)
From [Portfolio Project].dbo.[NashvilleHousing]
group by soldasvacant
order by(soldasvacant)

select soldasvacant
, case when soldasvacant = 'y' then 'yes'
       when soldasvacant = 'n' then 'no'
	   else soldasvacant
	   end
	   From [Portfolio Project].dbo.[NashvilleHousing]

set soldasvacant	
, case when soldasvacant = 'y' then 'yes'
       when soldasvacant = 'n' then 'no'
	   else soldasvacant
	   end
	   From [Portfolio Project].dbo.[NashvilleHousing]








# REMOVE DUPLICATES


select *,
ROW_NUMBER() over (
partition by parcelid,
             propertyaddress,
			 saleprice,
			 saledate,
			 legalreference
			 order by 
			 uniqueid 
			 ) row_num
from [Portfolio Project].dbo.NashvilleHousing

select *
from rownumCTE
where ROW_NUMBER > 1
order by propertyaddress







# DELETE UNUSED COLUMNS

select * from [Portfolio Project].dbo.NashvilleHousing
alter table [Portfolio Project].dbo.NashvilleHousing
drop column owneraddress, taxdistrict, propertyaddress

alter table [Portfolio Project].dbo.NashvilleHousing
drop column saledate