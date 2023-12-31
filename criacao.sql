-------------------
-- CRIAÇÃO DO BD --
-------------------

--CRIA TABELA TURISTA
CREATE TABLE TURISTA (
    NUM_CADASTRO VARCHAR(10),
    NOME VARCHAR(20), 
    CONSTRAINT PK_TURISTA PRIMARY KEY (NUM_CADASTRO)
);

--CRIA TABELA PACOTE PROMOCIONAL
CREATE TABLE PACOTE_PROMOCIONAL (
    COD_PROMOCIONAL VARCHAR(10),
    CONSTRAINT PK_PACOTE_PROMOCIONAL PRIMARY KEY (COD_PROMOCIONAL)
);

--CRIA TABELA PROPRIETARIO
CREATE TABLE PROPRIETARIO (
    CPF VARCHAR(11),
    NOME VARCHAR(20), 
    CONSTRAINT PK_PROPRIETARIO PRIMARY KEY (CPF)
);

--CRIA TABELA FAZENDA 
CREATE TABLE FAZENDA (
    COD_PROPRIEDADE VARCHAR(10),
    END_LOTE VARCHAR(20),
    END_NUMERO VARCHAR(5),
    CPF VARCHAR(11) NOT NULL,
    CONSTRAINT CPF_FAZENDA_FK FOREIGN KEY (CPF) REFERENCES PROPRIETARIO ON DELETE CASCADE,
    CONSTRAINT FAZENDA_PK PRIMARY KEY (COD_PROPRIEDADE)   
);

--CRIA TABELA FUNCIONARIO
CREATE TABLE FUNCIONARIO(
    ID VARCHAR(3),
    NOME VARCHAR(20), 
    COD_PROPRIEDADE VARCHAR(10) NOT NULL,
    ID_GERENTE VARCHAR(3),
    DATA_ADMISSAO DATE,
    CONSTRAINT FUNCIONARIO_PK PRIMARY KEY (ID),
    CONSTRAINT FUNCIONARIO_COD_FK FOREIGN KEY (COD_PROPRIEDADE) REFERENCES FAZENDA ON DELETE CASCADE,
    CONSTRAINT FUNCIONARIO_GERENTE_FK FOREIGN KEY (ID_GERENTE) REFERENCES FUNCIONARIO 
);

--CRIA TABELA SETOR
CREATE TABLE SETOR(
    ID_ART NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NOME VARCHAR(10),
    RECURSO NUMBER(10,2),
    RESPONSAVEL VARCHAR(3) NOT NULL UNIQUE, 
    CONSTRAINT CHK_RECURSO CHECK (RECURSO >= 0 ),
    CONSTRAINT RESPONSAVEL_ID_FK FOREIGN KEY (RESPONSAVEL) REFERENCES FUNCIONARIO ON DELETE CASCADE
);

--CRIA TABELA TRABALHA
CREATE TABLE TRABALHA(
    ID_ART,
    ID VARCHAR(3),
    CONSTRAINT TRABALHA_PK PRIMARY KEY (ID_ART, ID),
    CONSTRAINT TRABALHA_COD__FK FOREIGN KEY (ID_ART) REFERENCES SETOR ON DELETE CASCADE,
    CONSTRAINT TRABALHA_ID__FK FOREIGN KEY (ID) REFERENCES FUNCIONARIO ON DELETE CASCADE
);

--CRIA TABELA FIXO
CREATE TABLE FIXO(
    ID VARCHAR(3),
    CONSTRAINT FIXO_PK PRIMARY KEY (ID),
    CONSTRAINT FIXO_FK FOREIGN KEY (ID) REFERENCES FUNCIONARIO ON DELETE CASCADE
);

--CRIA TABELA TEMPORARIO
CREATE TABLE TEMPORARIO(
    ID VARCHAR(3),
    TEMPO_CONTRATO NUMBER(4),
    CONSTRAINT TEMPORARIO_PK PRIMARY KEY (ID),
    CONSTRAINT TEMPORARIO_FK FOREIGN KEY (ID) REFERENCES FUNCIONARIO ON DELETE CASCADE   
);

-- CRIA TABELA ANIMAL
CREATE TABLE ANIMAL ( 
    CODIGO VARCHAR(20), 
    NOME VARCHAR(20), 
    ESPECIE VARCHAR(30),
    SEXO CHAR(1), 
    DATA_NASC DATE, 
    CUIDADOR VARCHAR(3) NOT NULL,
    CONSTRAINT PK_ANIMAL PRIMARY KEY (CODIGO),
    CONSTRAINT CUIDADOR_ID_FK FOREIGN KEY (CUIDADOR) REFERENCES FUNCIONARIO ON DELETE CASCADE, 
    CONSTRAINT AK_ANIMAL UNIQUE (NOME, DATA_NASC) 
);

--CRIA TABELA ALIMENTACAO 
CREATE TABLE ALIMENTACAO (
    CODIGO VARCHAR(20),
    ALIMENTACAO VARCHAR(20),
    CONSTRAINT PK_ALIMENTACAO PRIMARY KEY (CODIGO, ALIMENTACAO),
    CONSTRAINT ALIMENTACAO_ANIMAL_FK FOREIGN KEY (CODIGO) REFERENCES ANIMAL ON DELETE CASCADE
);

--CRIA TABELA EQUIPAMENTOS     
CREATE TABLE EQUIPAMENTOS(
    CODIGO VARCHAR(20),
    NUMERO VARCHAR(3),
    CONSTRAINT EQUIPAMENTOS_PK PRIMARY KEY (CODIGO, NUMERO),
    CONSTRAINT EQUIPAMENTOS_FK FOREIGN KEY (CODIGO) REFERENCES ANIMAL ON DELETE CASCADE
);
 
--CRIA TABELA HOSPEDA
CREATE TABLE HOSPEDA(
    NUM_CADASTRO VARCHAR(3),
    COD_PROPRIEDADE VARCHAR(10),
    DATA_VISIT DATE,
    CONSTRAINT HOSPEDA_PK PRIMARY KEY (NUM_CADASTRO, COD_PROPRIEDADE, DATA_VISIT),
    CONSTRAINT HOSPEDA_NUM_FK FOREIGN KEY (NUM_CADASTRO) REFERENCES TURISTA ON DELETE CASCADE,
    CONSTRAINT HOSPEDA_COD_FK FOREIGN KEY (COD_PROPRIEDADE) REFERENCES FAZENDA ON DELETE CASCADE    
);

--CRIA TABELA APRESENTA
CREATE TABLE APRESENTA(
    NUM_CADASTRO VARCHAR(3),
    CODIGO VARCHAR(20),
    ID VARCHAR(3),
    CONSTRAINT APRESENTA_PK PRIMARY KEY (NUM_CADASTRO, CODIGO, ID),
    CONSTRAINT APRESENTA_NUM_FK FOREIGN KEY (NUM_CADASTRO) REFERENCES TURISTA ON DELETE CASCADE,
    CONSTRAINT APRESENTA_COD_FK FOREIGN KEY (CODIGO) REFERENCES ANIMAL ON DELETE CASCADE,
    CONSTRAINT APRESENTA_ID_FK FOREIGN KEY (ID) REFERENCES TEMPORARIO ON DELETE CASCADE    
);

--CRIA TABELA INVESTE
CREATE TABLE INVESTE(
    CPF VARCHAR(11),
    COD_PROPRIEDADE VARCHAR(10),
    CONSTRAINT INVESTE_PK PRIMARY KEY (COD_PROPRIEDADE, CPF),
    CONSTRAINT INVESTE_CPF_FK FOREIGN KEY (CPF) REFERENCES PROPRIETARIO ON DELETE CASCADE,
    CONSTRAINT INVESTE_COD_FK FOREIGN KEY (COD_PROPRIEDADE) REFERENCES FAZENDA ON DELETE CASCADE    
);

--CRIA TABELA COMPRA
CREATE TABLE COMPRA( 
    COD_PROMOCIONAL VARCHAR(10), 
    NUM_CADASTRO VARCHAR(3), 
    COD_PROPRIEDADE VARCHAR(10), 
    DATA_VISIT DATE, 
    CONSTRAINT COMPRA_PK PRIMARY KEY (NUM_CADASTRO, COD_PROMOCIONAL, COD_PROPRIEDADE, DATA_VISIT), 
    CONSTRAINT COMPRA_NUM_FK FOREIGN KEY (NUM_CADASTRO, COD_PROPRIEDADE, DATA_VISIT) REFERENCES HOSPEDA(NUM_CADASTRO, COD_PROPRIEDADE, DATA_VISIT) ON DELETE CASCADE, 
    CONSTRAINT COMPRA_COD_PROMOCIONAL_FK FOREIGN KEY (COD_PROMOCIONAL) REFERENCES PACOTE_PROMOCIONAL(COD_PROMOCIONAL) ON DELETE CASCADE 
);