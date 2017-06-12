package view;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.GroupLayout;
import javax.swing.GroupLayout.Alignment;
import javax.swing.JButton;
import javax.swing.LayoutStyle.ComponentPlacement;
import javax.swing.JProgressBar;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.SwingConstants;

public class TelaPrincipal extends JFrame {

	private JPanel contentPane;
	private JTable table;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					TelaPrincipal frame = new TelaPrincipal();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public TelaPrincipal() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.CENTER);
		
		JButton btnAlunos = new JButton("Alunos");
		
		JButton btnDisciplina = new JButton("Disciplina");
		
		JButton btnFaltas = new JButton("Faltas");
		
		JLabel lblNotas = new JLabel("notas");
		
		table = new JTable();
		
		JButton btnAvaliacao = new JButton("avalia\u00E7\u00E3o");
		btnAvaliacao.setHorizontalAlignment(SwingConstants.LEFT);
		GroupLayout gl_panel = new GroupLayout(panel);
		gl_panel.setHorizontalGroup(
			gl_panel.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panel.createSequentialGroup()
					.addContainerGap()
					.addGroup(gl_panel.createParallelGroup(Alignment.LEADING)
						.addComponent(lblNotas)
						.addComponent(table, GroupLayout.DEFAULT_SIZE, 60, Short.MAX_VALUE))
					.addPreferredGap(ComponentPlacement.RELATED)
					.addGroup(gl_panel.createParallelGroup(Alignment.LEADING)
						.addComponent(btnFaltas)
						.addComponent(btnDisciplina)
						.addComponent(btnAlunos)
						.addComponent(btnAvaliacao))
					.addGap(11))
		);
		gl_panel.setVerticalGroup(
			gl_panel.createParallelGroup(Alignment.LEADING)
				.addGroup(gl_panel.createSequentialGroup()
					.addGap(70)
					.addComponent(btnAlunos)
					.addPreferredGap(ComponentPlacement.UNRELATED)
					.addComponent(btnDisciplina)
					.addPreferredGap(ComponentPlacement.UNRELATED)
					.addComponent(btnFaltas)
					.addGap(18)
					.addComponent(btnAvaliacao)
					.addContainerGap(50, Short.MAX_VALUE))
				.addGroup(Alignment.TRAILING, gl_panel.createSequentialGroup()
					.addContainerGap(56, Short.MAX_VALUE)
					.addComponent(lblNotas)
					.addPreferredGap(ComponentPlacement.RELATED)
					.addComponent(table, GroupLayout.PREFERRED_SIZE, 127, GroupLayout.PREFERRED_SIZE)
					.addGap(38))
		);
		panel.setLayout(gl_panel);
	}
}
