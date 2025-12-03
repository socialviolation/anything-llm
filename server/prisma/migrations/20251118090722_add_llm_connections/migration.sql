-- CreateTable
CREATE TABLE "llm_connections" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "config" TEXT NOT NULL,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUpdatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "llm_connections_pkey" PRIMARY KEY ("id")
);

-- AlterTable
ALTER TABLE "workspaces" ADD COLUMN "chatConnectionId" INTEGER;
ALTER TABLE "workspaces" ADD COLUMN "chatModelOverride" TEXT;
ALTER TABLE "workspaces" ADD COLUMN "agentConnectionId" INTEGER;
ALTER TABLE "workspaces" ADD COLUMN "agentModelOverride" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "llm_connections_name_key" ON "llm_connections"("name");

-- CreateIndex
CREATE INDEX "llm_connections_provider_idx" ON "llm_connections"("provider");

-- CreateIndex
CREATE INDEX "llm_connections_provider_isDefault_idx" ON "llm_connections"("provider", "isDefault");

-- CreateIndex
CREATE INDEX "workspaces_chatConnectionId_idx" ON "workspaces"("chatConnectionId");

-- CreateIndex
CREATE INDEX "workspaces_agentConnectionId_idx" ON "workspaces"("agentConnectionId");

-- AddForeignKey
ALTER TABLE "workspaces" ADD CONSTRAINT "workspaces_chatConnectionId_fkey" FOREIGN KEY ("chatConnectionId") REFERENCES "llm_connections"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspaces" ADD CONSTRAINT "workspaces_agentConnectionId_fkey" FOREIGN KEY ("agentConnectionId") REFERENCES "llm_connections"("id") ON DELETE SET NULL ON UPDATE CASCADE;
