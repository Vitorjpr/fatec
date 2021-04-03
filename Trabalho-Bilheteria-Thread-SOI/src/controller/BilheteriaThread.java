package controller;

import java.util.concurrent.Semaphore;

public class BilheteriaThread extends Thread {
	
	public static Integer qtdTotalIngressos = 100;
	private Integer idPessoa;
	private Integer tempoEsperaLogin;
	private Integer tempoEsperaCompra;
	private Integer qtdIngressosDesejados;
	private Semaphore semaforo;
	
	public BilheteriaThread(Integer idPerson, Semaphore semaforo) {
		this.idPessoa = idPerson;
		this.semaforo = semaforo;
		this.tempoEsperaLogin = 0;
		this.tempoEsperaCompra = 0;
		this.qtdIngressosDesejados = 0;
	}
	
	/**
		caso loginNoSistema tenha sido executado com sucesso, prossigo para
		processoDeCompra, se não, finalizo a thread

		caso processoDeCompra seja executado com sucesso, prossigo para 
		validacaoCompra, se não, finalizo a thread

		inicio o semanaforo com limite 1, indicando que somente uma thread
		pode executar este metodo por vez.

		executo a validacaoCompra e independentemente deste step ser executado 
		com sucesso ou não, devolvo o recurso para a proxima thread.

	 */
	public void run() {
		if(loginNoSistema()) {
			if(processoDeCompra()) {
				try {
					semaforo.acquire();
					validacaoCompra();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					semaforo.release();
				}
			}
		}
	}

	/**
		utilizo o metodo numeroAleatorioEntre() para retornar um valor aleatório 
		entre o range informado

		executo o metodo sleep com base no valor aleatório obtido

		caso o valor seja maior que 1000(1s), retorno mensagem contendo erro
		por timeout

		se não, atribuo um valor aleatório entre 1 e 4 a variável que corresponde
		a quantidade de ingressos que o usuario quer e retorno true, como
		sinal de que o step foi executado com sucesso.
	 */
	public boolean loginNoSistema() {
		this.tempoEsperaLogin = numeroAleatorioEntre(500, 2001);
		
		try {
			sleep(this.tempoEsperaLogin);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		if(this.tempoEsperaLogin >= 1000) {
			System.out.println("Usuário de ID " + idPessoa + " recebeu timeout ao fazer Login após " + this.tempoEsperaLogin + "ms.");
			return false;
		} else {
			System.out.println("Usuário de ID " + idPessoa + " Conseguiu logar no sistema após " + this.tempoEsperaLogin + "ms.");
			this.qtdIngressosDesejados = numeroAleatorioEntre(1, 5);
			return true;
		}
	}
	
	/**
		atribuo um valor aleatorio entre 1000 e 3000, representando 1s-3s. 

		Executo sleep com base neste valor 
		caso o tempo obtido seja superior ou igual a 2500, mostro mensagem
		contendo erro por tempo de sessão e retorno false, indicando falha no step.

		caso nao tenha entrado na condicional, retorno true indicando sucesso na
		operacao
	 */
	public boolean processoDeCompra() {
		this.tempoEsperaCompra = numeroAleatorioEntre(1000, 3001);
		try {
			sleep(this.tempoEsperaCompra);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		if(this.tempoEsperaCompra >= 2500) {
			System.out.println("Usuário de ID " + idPessoa + " teve sua sessão finalizada após " + this.tempoEsperaCompra + "ms.");
			return false;
		}
		
		return true;
	}
	
	/**
		verifica se a quantidade de ingressos disponíveis é maior que a quantidade
		que o usuario quer comprar

		caso seja verdade, subtraio a quantidade comprada da quantidade total e
		mostro a mensagem informando o usuario, a quantidade comprada, a quantidade
		ainda disponível e retorno true, informando que a operação foi feita com sucesso

		se nao, informo que o usuário não conseguiu comprar pois a quantidade
		que queria comprar era maior que a quantidade dispoível e retorno false
		sinalizando falha.
	 */
	public boolean validacaoCompra() {
		if(qtdTotalIngressos >= this.qtdIngressosDesejados) {
			qtdTotalIngressos -= this.qtdIngressosDesejados;
			System.out.println("Usuário de ID " + idPessoa + " conseguiu comprar " + this.qtdIngressosDesejados + ". Restam apenas: " + qtdTotalIngressos + " ingressos.");
			return true;
		} else {
			System.out.println("Usuário de ID " + idPessoa + " não conseguiu comprar " + this.qtdIngressosDesejados + " ingressos pois restam apenas: " + qtdTotalIngressos + " ingressos.");
			return false;
		}
	}
	
	/**
		Método auxiliar que retorna um número inteiro entre um valor min e
		max -1 informados por parâmetro
	 */
	public int numeroAleatorioEntre(Integer min, Integer max){
		Integer numeroAleatorio = min + (int)(Math.random() * (max - min));
	    return numeroAleatorio;
	}
}