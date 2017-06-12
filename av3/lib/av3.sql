create database av3
go
use av3

--ler denovo para ver os tipos de dados
select * from faltas
create table aluno(ra int primary key,
nome varchar(100))

create table disciplina(codigo int primary key, 
nome varchar(100),
sigla varchar(30),
turno char(1),
num_aulas int)

create table faltas(ra_aluno int foreign key references aluno,
codigo_disciplina int foreign key references disciplina,
data date,
presenca varchar(4),
CONSTRAINT PK_DataPK PRIMARY KEY (data,ra_aluno,codigo_disciplina))

drop table faltas

create table avaliacao(codigo int primary key ,
tipo varchar(11))

create table notas(ra_aluno int foreign key references aluno,
codigo_disciplina int foreign key references disciplina,
codigo_avaliacao int foreign key references avaliacao,
nota /* tem que mudar pra decimal, dei drop mas n foi por conta da restrição de fk*/decimal(7,2))





drop table aluno
drop table disciplina
drop table faltas
drop table notas
drop table avaliacao
----------------------------------------------------------------------------------------------------------------------
create procedure pc_inserirNota(@nome_aluno varchar(100),
@disciplina.nome varchar(50),
@turno char(1),
@avaliacao.tipo varchar(20),
@nota decimal(7,2)
)
as 
declare @ra_aluno varchar(10),
@codigo_disciplina varchar(10),
@codigo_avaliacao int
set @ra_aluno = (select ra from aluno where nome = @nome_aluno)
set @codigo_disciplina = (select disciplina.codigo from disciplina where disciplina.nome = @disciplina and disciplina.turno=@turno)
set @codigo_avaliacao  = (select avaliacao.codigo from avaliacao where avaliacao.tipo = @avaliacao)
insert into notas values (@ra_aluno, @codigo_disciplina, @codigo_avaliacao, @nota)




create procedure pc_inserirFalta(@nome_aluno,@nome_disciplina,@turno,@data,@presenca)
as
declare
@ra int,
@codigo_disciplina int
set @ra=(select aluno.ra from aluno where aluno.nome=@nome_aluno)
set @codigo_disciplina=(select disciplina.codigo from disciplina where disciplina.nome=@nome_disciplina and disciplina.turno=@turno)
insert into faltas
insert into faltas values(@ra,@codigo_disciplina,@data,@presenca)

--------------------------------------------------------------------------------------------------------------------


/*essa function deve pegar o codigo da disciplina de um combobox no java e turno, dps crio um retorno do tipo tabela com os atributos de ra do aluno, nome, nota 1,2... além de sua media final e situação,
blz feito isto declaro uma variavel   */
create function fn_notasTurma(@codigo_disciplina int,@turno char)--não sei
returns @tabela table(
ra int,
nome_aluno varchar(100),
nota1 decimal(7,2),
nota2 decimal(7,2),
nota3 decimal(7,2),
exame decimal(7,2),
/*talvez algo*/
media_final decimal(7,2),
situacao varchar(9))/*Aprovado ou Reprovado*/
as begin
declare
@ra int,
@nome_aluno varchar(100),
@nota1 decimal(7,2),
@nota2 decimal(7,2),
@nota3 decimal(7,2),
@exame decimal(7,2),
@media_final decimal(7,2),
@disciplina_nome varchar(100),
@situacao varchar (100)
set @disciplina_nome=
(select disciplina.nome
from disciplina
where disciplina.codigo=@codigo_disciplina)--talvez deva colocar o turno tb
declare c_busca cursor for
select distinct al.ra
from aluno al
inner join notas nt
on nt.ra_aluno=al.ra
inner join disciplina dis
on nt.codigo_disciplina=dis.codigo
where dis.codigo=@codigo_disciplina and dis.turno=@turno
open c_busca
fetch next from c_busca
into @ra
WHILE @@FETCH_STATUS = 0
begin
set @exame=null
if (@disciplina_nome like 'Arquitetura e Organização de Computadores' or @disciplina_nome like 'Laboratório de Hardware' or @disciplina_nome like 'Banco de Dados' )
begin
set @nome_aluno=(select aluno.nome 
from aluno
where aluno.ra=@ra)
set @nota1 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P1')
set @nota2 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P2')
set @nota3 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'T')
set @media_final=(@nota1*0.3+@nota2*0.5+@nota3*0.2)
if (@media_final>3 and @media_final < 6) 
begin
set @exame=(select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'Exame')
set @media_final=(((@nota1*0.3+@nota2*0.5+@nota3*0.2)+@exame)/2)
end
end
else if(@disciplina_nome like 'Sistemas Operacionais I')
begin
set @nome_aluno=(select aluno.nome 
from aluno
where aluno.ra=@ra)
set @nota1 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P1')
set @nota2 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P2')
set @nota3 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'T')
set @media_final=(@nota1*0.35+@nota2*0.35+@nota3*0.3)
if (@media_final>3 and @media_final < 6) 
begin
set @exame=(select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'Exame')
set @media_final=(((@nota1*0.35+@nota2*0.35+@nota3*0.3)+@exame)/2)
end
end
else if(@disciplina_nome like 'Laboratório de Banco de Dados')
begin
set @nome_aluno=(select aluno.nome 
from aluno
where aluno.ra=@ra)
set @nota1 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P1')
set @nota2 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'P2')
set @nota3 = (select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'T')
set @media_final=(@nota1*0.33+@nota2*0.33+@nota3*0.33)
if (@media_final>3 and @media_final < 6) 
begin
set @exame=(select notas.nota
from notas
inner join  avaliacao
on notas.codigo_avaliacao=avaliacao.codigo
where notas.ra_aluno=@ra and avaliacao.tipo like 'Exame')
set @media_final=(((@nota1*0.33+@nota2*0.33+@nota3*0.33)+@exame)/2)
end
end
if(@media_final >6 and @exame is null)
begin
set @exame=0
set @situacao='Aprovado'
end
else if(@media_final>6 and @exame is not null)
begin
set @media_final=6
set @situacao='Aprovado'
end
else
begin 
set @situacao='Reprovado'
end
INSERT INTO @tabela VALUES
		(@ra, @nome_aluno, @nota1, @nota2,@nota3,@exame,@media_final,@situacao)
fetch next from c_busca
into @ra
end
CLOSE c_busca
DEALLOCATE c_busca
return
end

select * from fn_notasTurma(4233005
,'T') 

select * from disciplina


select ra,nome_aluno,data1 as '10/08',data2 AS '17/08',data3 AS '24/08',data4 AS '31/08'  from fn_faltasTurma(4203010
,'T') 

select * from disciplina


create function fn_faltasTurma(@codigo_disciplina int,@turno char)--não sei
returns @tabela table(
ra int,
nome_aluno varchar(100),
data1 varchar(4),
data2 varchar(4),
data3 varchar(4),
data4 varchar(4))
/*talvez algo*/
as begin
declare
@disciplina_nome varchar(100),
@ra int,
@nome_aluno varchar(100),
@data date,
@data1 varchar(4),
@data2 varchar(4),
@data3 varchar(4),
@data4 varchar(4),
@total int
set @disciplina_nome=
(select disciplina.nome
from disciplina
where disciplina.codigo=@codigo_disciplina)--talvez deva colocar o turno tb
declare c_busca cursor for
select distinct al.ra--,ft.data
from aluno al
inner join faltas ft
on ft.ra_aluno=al.ra
inner join disciplina dis
on ft.codigo_disciplina=dis.codigo
where dis.codigo=@codigo_disciplina and dis.turno=@turno
open c_busca
fetch next from c_busca
into @ra
WHILE @@FETCH_STATUS = 0
begin
set @nome_aluno=(select aluno.nome from aluno where aluno.ra=@ra)
declare c_falta cursor local for
select distinct ft.data
from faltas ft
where ft.ra_aluno=@ra
open c_falta
fetch next from c_falta
into @data
while @@FETCH_STATUS=0
begin
/*INSERT INTO @tabela VALUES
		(@ra, @nome_aluno,@data1,@data2,@data3,@data4)*/
IF @data = '2017-08-10'
  BEGIN
  if @disciplina_nome not like 'Laboratório de Hardware'
begin
set @data1=(select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
else
begin
set @data1=(select case
 when faltas.presenca='2' then 'FF'
 When faltas.presenca='1' then 'PF'
 When faltas.presenca='0' then 'PP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end

   /*UPDATE @tabela
   SET  DATA1  = @data1
   WHERE @ra = @ra*/  
  END 
  IF @data = '2017-08-17'
  BEGIN
   if @disciplina_nome not like 'Laboratório de Hardware'
begin
set @data2=(select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
else
begin
set @data2=(select case
 when faltas.presenca='2' then 'FF'
 When faltas.presenca='1' then 'PF'
 When faltas.presenca='0' then 'PP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
  
  END 
  IF @data = '2017-08-24'
  BEGIN
   if @disciplina_nome not like 'Laboratório de Hardware'
begin
set @data3=(select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
else
begin
set @data3=(select case
 when faltas.presenca='2' then 'FF'
 When faltas.presenca='1' then 'PF'
 When faltas.presenca='0' then 'PP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
  
  END 
  IF @data = '2017-08-31'
  BEGIN
   if @disciplina_nome not like 'Laboratório de Hardware'
begin
set @data4=(select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
else
begin
set @data4=(select case
 when faltas.presenca='2' then 'FF'
 When faltas.presenca='1' then 'PF'
 When faltas.presenca='0' then 'PP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
INSERT INTO @tabela VALUES
		(@ra, @nome_aluno,@data1,@data2,@data3,@data4)
 
  end
  fetch next from c_falta 
  into @data
  END
   close c_falta
deallocate c_falta 
fetch next from c_busca
into @ra
end
CLOSE c_busca
DEALLOCATE c_busca
return
end

select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=4203010 and faltas.ra_aluno=1510258


if @disciplina_nome not like 'Laboratório de Hardware'
begin
set @data1=(select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end
else
begin
set @data1=(select case
 when faltas.presenca='2' then 'FF'
 When faltas.presenca='1' then 'PF'
 When faltas.presenca='0' then 'PP' end as faltas
from faltas
where faltas.codigo_disciplina=@codigo_disciplina and faltas.ra_aluno=@ra and faltas.data=@data)
end

-----------------testando





select * from disciplina

select * from notas

select * from faltas

select case
 when faltas.presenca='4' then 'PPP'
 when faltas.presenca='3' then '1'
 when faltas.presenca='2' then '3'
 When faltas.presenca='1' then 'f'
 When faltas.presenca='0' then 'f' end as faltas
from faltas
where faltas.ra_aluno=1513850 and faltas.codigo_disciplina=4203010 



select distinct al.ra,ft.data
from aluno al
inner join faltas ft
on ft.ra_aluno=al.ra
inner join disciplina dis
on ft.codigo_disciplina=dis.codigo
where dis.codigo=4203010
 and dis.turno='T'



 select al.ra,ft.data
from aluno al
inner join faltas ft
on ft.ra_aluno=al.ra
inner join disciplina dis
on ft.codigo_disciplina=dis.codigo
where dis.codigo=4203010
 and dis.turno='T'

 select faltas.data
 from faltas





 select case
 when faltas.presenca='4' then 'FFFF'
 when faltas.presenca='3' then 'PFFF'
 when faltas.presenca='2' then 'PPFF'
 When faltas.presenca='1' then 'PPPF'
 When faltas.presenca='0' then 'PPPP' end as faltas
from faltas
where faltas.codigo_disciplina=4203010
 and faltas.ra_aluno=1510258
 and faltas.data='2017-08-10'

 select  distinct al.ra,ft.data
from aluno al
inner join faltas ft
on ft.ra_aluno=al.ra
inner join disciplina dis
on ft.codigo_disciplina=dis.codigo
where dis.codigo=4203010 and dis.turno='T'

 select * from faltas

 select * from aluno