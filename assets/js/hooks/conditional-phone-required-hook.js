/**
 * Hook to conditionally make phone input required based on preferred contact method selection
 * Attached to the phone input field, it listens for changes in contact method radio buttons
 */
const ConditionalPhoneRequiredHook = {
    mounted() {
        this.initializePhoneValidation();
    },

    initializePhoneValidation() {
        const phoneInput = this.el;
        const form = phoneInput.closest('form');

        if (!form) {
            console.warn('ConditionalPhoneRequiredHook: Phone input is not inside a form');
            return;
        }

        // Cache DOM elements
        this.phoneInput = phoneInput;
        this.contactMethodRadios = form.querySelectorAll('input[name="preferred_contact_method"]');

        // Store original placeholder for restoration
        this.originalPlaceholder = phoneInput.getAttribute('placeholder') || '';

        // Bind event handlers
        this.handleContactMethodChange = this.handleContactMethodChange.bind(this);

        // Attach event listeners
        this.contactMethodRadios.forEach(radio => {
            radio.addEventListener('change', this.handleContactMethodChange);
        });

        // Initialize state based on current selection
        this.updatePhoneRequirement();
    },

    handleContactMethodChange(event) {
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
        this.updatePlaceholder('(obligatoire)');
    },

    makePhoneOptional() {
        this.phoneInput.removeAttribute('required');
        this.updatePlaceholder('(optionnel)');
    },

    updatePlaceholder(status) {
        const basePlaceholder = this.originalPlaceholder.replace(/\s*\((?:obligatoire|optionnel)\)/, '');
        const newPlaceholder = `${basePlaceholder} ${status}`;
        this.phoneInput.setAttribute('placeholder', newPlaceholder);
    },

    destroyed() {
        // Cleanup event listeners
        if (this.contactMethodRadios) {
            this.contactMethodRadios.forEach(radio => {
                radio.removeEventListener('change', this.handleContactMethodChange);
            });
        }
    }
};

export default ConditionalPhoneRequiredHook;