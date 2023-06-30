({
    getData: function (cmp, event) {
        var action = cmp.get('c.DadosDaConta');
        action.setParams({ 'recordId': cmp.get("v.recordId") }),
            action.setCallback(this, $A.getCallback(function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    let result = response.getReturnValue();
                    
                    cmp.set("v.name", result.Name);
                    cmp.set("v.accountNumber", result.AccountNumber);
                    cmp.set("v.type", result.Type)
                    
                }
                
            }));
        
        $A.enqueueAction(action);
    },
    
    salvar: function (cmp, row) {
		cmp.set('v.loaded', false);

		let buttonAction = cmp.get('c.Salvar');
		buttonAction.setParams({
			'recordId': cmp.get("v.recordId"),
			'name': cmp.get('v.name'),
			'accountNumber': cmp.get('v.accountNumber'),
			'type': cmp.get('v.type')
		});
		buttonAction.setCallback(this, $A.getCallback(function (response) {
			let results = response.getReturnValue();
			console.log('STATE: ',response.getState());
			console.log('results: ',results);
			if (response.getState() == 'SUCCESS' && results == 'success') {
				cmp.set('v.loaded', true);
				$A.get("e.force:refreshView").fire();
				$A.get("e.force:closeQuickAction").fire();
			}
			else if (results.split(' ')[0] == 'validation'){
				
				cmp.set('v.loaded', true);
				this.LightningAlert.open({
					label: 'Erro ao salvar:',
					message: results.replace('validation', ''),
					theme: 'error',
				}).then(function () {
					console.log('alert is closed');
				});
			}
			else {
				cmp.set('v.loaded', true);
				this.LightningAlert.open({
					label: `Erro na execução do script.`,
					message: 'Favor contatar um administrador.',
					theme: 'error',
				}).then(function () {
					console.log('alert is closed');
				});
			}
		}))

		$A.enqueueAction(buttonAction);

	},
    
    alertaErro: function (cmp, event) {
        this.LightningAlert.open({
            message: 'Preencha o campo Name e AccountNumber',
            theme: 'error',
            label: 'Atenção!',
        }).then(function () {
            console.log('alert is closed');
        });
    }
})