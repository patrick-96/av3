package model;

import java.util.Date;

public class Faltas {
/*ra_aluno int foreign key references aluno,
codigo_disciplina int foreign key references disciplina,
data date,
presenca varchar(4),
CONSTRAINT PK_DataPK PRIMARY KEY (data,ra_aluno,codigo_disciplina))*/
	
	private int ra_aluno;
	private int cod_disciplina;
	private Date Data = new Date();
	public int getRa_aluno() {
		return ra_aluno;
	}
	public void setRa_aluno(int ra_aluno) {
		this.ra_aluno = ra_aluno;
	}
	public int getCod_disciplina() {
		return cod_disciplina;
	}
	public void setCod_disciplina(int cod_disciplina) {
		this.cod_disciplina = cod_disciplina;
	}
	public Date getData() {
		return Data;
	}
	public void setData(Date data) {
		Data = data;
	}
	
	
}
