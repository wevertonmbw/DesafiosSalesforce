({
	init: function (cmp, event, helper) {
		var actions = [
			{ label: 'Salvar', name: 'salvar' },
		];

		helper.getData(cmp, event);
	},

	salvar: function (cmp, event, helper) {
		var name = cmp.get('v.name');
		var accountNumber = cmp.get('v.accountNumber');
		if(name){
			helper.salvar(cmp);
		}
		else{
			helper.alertaErro(cmp, event);
		}
    },

	fecharPopup: function () {
		$A.get("e.force:closeQuickAction").fire();
	}
})