# Projetos em VHDL  

Este repositório contém exemplos e projetos escritos em **VHDL** (*VHSIC Hardware Description Language*), uma linguagem usada para descrever, simular e sintetizar circuitos digitais.  

---

## 📌 Requisitos de Instalação  

Para compilar e simular os arquivos `.vhd`, você precisará de um ambiente de desenvolvimento VHDL. Algumas opções:  

- [GHDL](https://ghdl.github.io/ghdl/) → Simulador gratuito e de código aberto.  
- [ModelSim](https://eda.sw.siemens.com/en-US/ic/modelsim/) → Muito usado em universidades e indústrias.  
- [Vivado (Xilinx)](https://www.xilinx.com/support/download.html) → Para FPGAs da Xilinx.  
- [Quartus (Intel/Altera)](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html) → Para FPGAs da Intel/Altera.  

### 🧩 Estruturas Básicas do VHDL

Entity (Entidade) → Define a interface do circuito (entradas e saídas).

Architecture (Arquitetura) → Descreve o funcionamento interno da entidade.

Signal (Sinal) → Interliga componentes e armazena valores internos.

Process (Processo) → Bloco sequencial que reage a eventos em sinais.

Component (Componente) → Permite instanciar outras entidades.

### 🧪 O que é um Testbench?

Um testbench é um arquivo VHDL criado apenas para simulação.
Ele não é sintetizável em hardware, mas serve para verificar se o projeto funciona corretamente.

Nesse projeto utilizei o prefixo tb_ para indicar os arquivos de testbench

O testbench geralmente:

Declara sinais que simulam entradas e saídas.

Instancia a entidade a ser testada.

Aplica estímulos de entrada.

Observa e registra as saídas em forma de onda.
