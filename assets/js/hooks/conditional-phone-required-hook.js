/**
 * Hook to conditionally make phone input required based on preferred contact method selection
 * Attached to the phone input field, it listens for changes in contact method radio buttons
 */
const ConditionalPhoneRequiredHook = {
    mounted() {
        this.initializePhoneValidation();
    },

    initializePhoneValidation() {
        this.phoneInput = this.el;
        const form = this.phoneInput.closest('form');
        this.contactMethodRadios = form.querySelectorAll('input[name="preferred_contact_method"]');

        // Récupérer le label existant - CoreComponents.input wraps input in label
        // La structure est: <label><span class="label mb-1">Texte</span><input>...</label>
        const labelElement = this.phoneInput.closest('label');
        if (labelElement) {
            this.phoneLabel = labelElement.querySelector('span.label');
            if (this.phoneLabel) {
                this.originalLabelText = this.phoneLabel.textContent;
            }
        }

        this.updatePhoneRequirement = this.updatePhoneRequirement.bind(this);

        this.contactMethodRadios.forEach(radio => {
            radio.addEventListener('change', this.updatePhoneRequirement);
        });

        this.updatePhoneRequirement();
    },

    updatePhoneRequirement() {
        const isPhoneSelected = this.isContactMethodSelected('phone');

        if (isPhoneSelected) {
            this.makePhoneRequired();
        } else {
            this.makePhoneOptional();
        }
    },

    isContactMethodSelected(method) {
        return Array.from(this.contactMethodRadios)
            .some(radio => radio.value === method && radio.checked);
    },

    makePhoneRequired() {
        this.phoneInput.setAttribute('required', 'required');
        this.updateLabel('(obligatoire)');
    },

    makePhoneOptional() {
        this.phoneInput.removeAttribute('required');
        this.updateLabel('(optionnel)');
    },

    updateLabel(status) {
        if (this.phoneLabel) {
            const baseLabelText = this.originalLabelText.replace(/\s*\((?:obligatoire|optionnel)\)/, '');
            const newLabelText = `${baseLabelText} ${status}`;
            this.phoneLabel.textContent = newLabelText;
        }
    },

    destroyed() {
        if (this.contactMethodRadios) {
            this.contactMethodRadios.forEach(radio => {
                radio.removeEventListener('change', this.updatePhoneRequirement);
            });
        }
    }
};

export default ConditionalPhoneRequiredHook;