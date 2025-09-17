const ConditionalRequiredPhoneHook = {
  mounted() {
    const phoneInput = this.el;
    const form = phoneInput.closest('form');
    
    if (!form) return;
    
    // Fonction pour mettre à jour le statut requis du champ téléphone
    const updatePhoneRequired = () => {
      const phoneRadio = form.querySelector('input[name="preferred_contact_method"][value="phone"]');
      const emailRadio = form.querySelector('input[name="preferred_contact_method"][value="email"]');
      
      if (phoneRadio && phoneRadio.checked) {
        phoneInput.setAttribute('required', 'required');
        phoneInput.setAttribute('placeholder', phoneInput.getAttribute('placeholder').replace('(optionnel)', '(obligatoire)'));
      } else if (emailRadio && emailRadio.checked) {
        phoneInput.removeAttribute('required');
        phoneInput.setAttribute('placeholder', phoneInput.getAttribute('placeholder').replace('(obligatoire)', '(optionnel)'));
      }
    };
    
    // Écouter les changements sur les boutons radio
    const contactMethodRadios = form.querySelectorAll('input[name="preferred_contact_method"]');
    contactMethodRadios.forEach(radio => {
      radio.addEventListener('change', updatePhoneRequired);
    });
    
    // Initialiser l'état au chargement
    updatePhoneRequired();
  }
};

export default ConditionalRequiredPhoneHook;