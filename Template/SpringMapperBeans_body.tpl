
		${TRY}

			${CLASS_MODEL} model = new ${CLASS_MODEL}();

${SETTERS_MODEL}
			if (${OBJECT_NAME}AfterRules != null)
				${OBJECT_NAME}AfterRules.execute(model);
			return model;
${CATCH}