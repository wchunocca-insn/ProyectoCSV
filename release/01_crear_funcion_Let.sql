 
GO
/****** Object:  UserDefinedFunction [dbo].[doLet]    Script Date: 06/08/2023 03:51:46 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[doLet]
(
 @s_value    VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
begin

declare @s_patern varchar(500)
declare @i_index int,@i_index2 int
----
declare @i_let_N1 int
declare @i_let_N2 int
----
declare @i_row int
declare @i_ns int

set @s_patern='%[^ 0-9A-Za-z;:,.()!/\-]%'
set @i_ns=0
--CHAR(244)ô
--CHAR(43)+
--CHAR(230)æ    ├æ=Ñ
set @i_index=1
set @i_row=0

-----test
if patindex(@s_patern,@s_value)=0 begin
	IF CHARINDEX(CHAR(195),@s_value)=0 begin 
		return @s_value
	end
end
-----test


while @i_index!= 0  
begin
	set @i_index=patindex(@s_patern,@s_value)
	set @i_row=@i_row  +1 
	---IF @i_index=0 SET @i_index=CHARINDEX(CHAR(195),@s_value)
	if @i_row>10 begin
		break
	end

	IF @i_index=0 begin
		SET @i_index=CHARINDEX(CHAR(195),@s_value)
	end else begin
		--°
		set @i_let_N1=ascii(SUBSTRING(@s_value,@i_index,1))
		if @i_let_N1=176 or @i_let_N1=9 SET @i_index=CHARINDEX(CHAR(194),@s_value)
	end


	if @i_index>0 begin
		set @i_let_N1=ascii(SUBSTRING(@s_value,@i_index,1))
		set @i_let_N2=ascii(SUBSTRING(@s_value,@i_index+1,1))
	end else begin
		break
	end
	 

	--/├æ=Ñ / char: 43,230
	if @i_let_N1=43 and @i_let_N2=230 begin
		set @s_value=Concat( left(@s_value,@i_index-1),'Ñ',right(@s_value,(len(@s_value) -  (@i_index+1))))
		set @i_ns=1
	end
	--/├ô = O / char: ├=43 - ô=244
	if @i_let_N1=43 and @i_let_N2=244 begin
		set @s_value=Concat( left(@s_value,@i_index-1),'O',right(@s_value,(len(@s_value) -  (@i_index+1))))
		set @i_ns=1		 
	end
	
	--Ã‘ Ñ/  Ã=145 
	if @i_let_N1=145 begin 		 
		set @s_value=Concat( left(@s_value,@i_index-2),'Ñ',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1 
	end

	---Ã“ = 147 / Ó 
	if @i_let_N1=147 begin 	 
		set @s_value=Concat( left(@s_value,@i_index-2),'O',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1		 
	end

	---Ã“ = 129 / Á
	if @i_let_N1=129 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'A',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1		
	end

	---‰ = 129 / É
	if @i_let_N1=137 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'E',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end
	---Ãš = 195 /Ú
	if @i_let_N1=195 begin 
		set @s_value=Concat( left(@s_value,@i_index-1),'U',right(@s_value,(len(@s_value) -  (@i_index))-1  )  )
		set @i_ns=1
	end
	---‰ = 141 / í
	if @i_let_N1=141 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'I',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end
	---Â° = 194 / °
	if @i_let_N1=194 begin 
		set @s_value=Concat( left(@s_value,@i_index -1),'',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end

	---Â = 160 / ''
	if @i_let_N1=160 begin
		set @s_value=Concat( left(@s_value,@i_index-2),' ',right(@s_value,(len(@s_value) -  (@i_index))))
		 set @i_ns=1
	end



	if @i_ns=0 break
	set @i_ns=0
end

	return @s_value

end
